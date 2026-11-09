import sys, os, json, re, struct, zlib, hashlib
from PIL import Image
import numpy as np

def png_chunks(b):
    out=[]; i=8
    while i+8<=len(b):
        ln=struct.unpack('>I',b[i:i+4])[0]; t=b[i+4:i+8].decode('latin1')
        data=b[i+8:i+8+ln]; out.append((t,ln,data)); i+=12+ln
        if t=='IEND': break
    return out,i

def jpeg_segments(b):
    segs=[]; i=2; end=None
    while i<len(b)-1:
        if b[i]!=0xFF: i+=1; continue
        m=b[i+1]
        if m==0xD9: end=i+2; break
        if m in (0x01,) or 0xD0<=m<=0xD7: i+=2; continue
        if m==0xDA:
            ln=struct.unpack('>H',b[i+2:i+4])[0]
            j=i+2+ln
            # scan for EOI
            k=b.find(b'\xff\xd9',j)
            # last EOI in file is the true end typically
            end=b.rfind(b'\xff\xd9')+2
            segs.append(('SOS',ln,b''))
            break
        ln=struct.unpack('>H',b[i+2:i+4])[0]
        segs.append((hex(m),ln,b[i+4:i+2+ln])); i+=2+ln
    return segs,end

def printable_runs(data,minlen=12):
    return [m.group().decode('latin1') for m in re.finditer(rb'[\x20-\x7e\n\t]{%d,}'%minlen,data)]

def lsb_check(img):
    a=np.asarray(img.convert('RGB'),dtype=np.uint8)
    res={}
    bits=(a&1)
    res['lsb_mean_per_channel']=[round(float(bits[...,c].mean()),4) for c in range(3)]
    # try decoding first 4096 bytes of LSB stream in row-major RGB order
    flat=bits.reshape(-1)[:8*4096]
    by=np.packbits(flat).tobytes()
    runs=printable_runs(by,16)
    res['lsb_text_runs']=runs[:3]
    # pairs-of-values test (chi-square style) on R channel histogram
    h=np.bincount(a[...,0].reshape(-1),minlength=256).astype(float)
    ev=h[0::2]; od=h[1::2]; m=(ev+od)/2; mask=m>5
    chi=float((((ev-m)**2)/np.where(mask,m,1))[mask].sum()); dof=int(mask.sum())
    res['pov_chi2']=round(chi,1); res['pov_dof']=dof
    return res

def analyse(path):
    b=open(path,'rb').read()
    r={'file':os.path.basename(path),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()[:16]}
    meta=[]; trailing=0
    if b[:8]==b'\x89PNG\r\n\x1a\n':
        r['fmt']='PNG'; ch,end=png_chunks(b); trailing=len(b)-end
        for t,ln,d in ch:
            if t in('tEXt','iTXt','zTXt','eXIf','caBX','iCCP','pHYs','gAMA','sRGB','cHRM','tIME'):
                if t=='zTXt':
                    k,_,rest=d.partition(b'\0'); 
                    try: d=k+b': '+zlib.decompress(rest[1:])
                    except Exception: pass
                meta.append((t,ln,' | '.join(printable_runs(d,6))[:300]))
            elif t not in('IHDR','IDAT','IEND','PLTE','tRNS'):
                meta.append((t,ln,' | '.join(printable_runs(d,6))[:300]))
    elif b[:2]==b'\xff\xd8':
        r['fmt']='JPEG'; segs,end=jpeg_segments(b); trailing=len(b)-(end or len(b))
        for m,ln,d in segs:
            if m in('0xe0','0xdb','0xc0','0xc2','0xc4','0xdd','SOS'): continue
            meta.append((m,ln,' | '.join(printable_runs(d,6))[:300]))
    elif b[:4]==b'RIFF' and b[8:12]==b'WEBP':
        r['fmt']='WEBP'; ln=struct.unpack('<I',b[4:8])[0]; trailing=len(b)-(ln+8)
        i=12
        while i+8<=min(len(b),ln+8):
            t=b[i:i+4].decode('latin1'); l=struct.unpack('<I',b[i+4:i+8])[0]
            if t in('EXIF','XMP ','ICCP'): meta.append((t,l,' | '.join(printable_runs(b[i+8:i+8+l],6))[:300]))
            i+=8+l+(l&1)
    elif b[:6] in (b'GIF87a',b'GIF89a'):
        r['fmt']='GIF'
    else:
        r['fmt']='other:'+b[:12].hex(); return r
    r['trailing_bytes']=trailing
    if trailing>0:
        tail=b[len(b)-trailing:]
        r['trailing_head']=tail[:16].hex(); r['trailing_text']=printable_runs(tail,8)[:5]
    r['meta']=meta
    try:
        im=Image.open(path); r['size']=im.size; r['mode']=im.mode
        im.load(); r.update(lsb_check(im))
    except Exception as e:
        r['err']=str(e)
    return r

if __name__=='__main__':
    out=[]
    for p in sys.argv[2:]:
        try: out.append(analyse(p))
        except Exception as e: out.append({'file':p,'err':str(e)})
    json.dump(out,open(sys.argv[1],'w'),indent=1,default=str)
    print(len(out))
