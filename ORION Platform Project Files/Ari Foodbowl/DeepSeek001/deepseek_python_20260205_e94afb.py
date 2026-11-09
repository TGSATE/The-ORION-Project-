st.markdown("""
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Force white text in all textareas
    const textareas = document.querySelectorAll('textarea');
    textareas.forEach(ta => {
        ta.style.color = '#FFFFFF';
        ta.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    });
});
</script>
""", unsafe_allow_html=True)