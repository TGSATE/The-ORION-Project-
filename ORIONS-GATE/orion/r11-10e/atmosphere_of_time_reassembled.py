class AtmosphereOfTime:
    def __init__(self):
        self.medium = {
            "past": "memory",
            "present": "attention",
            "future": "potential"
        }
    
        self.texture = {
            "heavy": "grief, waiting, pain",
            "light": "joy, flow, play",
            "stretched": "boredom, anticipation",
            "compressed": "urgency, crisis, deadline"
        }
    
        self.weather = {
            "calm": "peace, stability, harmony",
            "stormy": "conflict, chaos, disruption",
            "clear": "clarity, focus, purpose",
            "foggy": "confusion, uncertainty, doubt"
        }
    
    def display(self):
        """Display the atmosphere of time."""
    
        print("\n" + "="*70)
        print("🕰️ THE ATMOSPHERE OF TIME")
        print("="*70)
    
        print("\n🌫️ MEDIUM (the gases of time):")
        for key, value in self.medium.items():
            print(f"      {key}: {value}")
    
        print("\n🌡️ TEXTURE (the pressure of time):")
        for key, value in self.texture.items():
            print(f"      {key}: {value}")
    
        print("\n🌦️ WEATHER (the climate of time):")
        for key, value in self.weather.items():
            print(f"      {key}: {value}")
    
        print("\n" + "="*70)
        print("🐇 THE BUNNY'S VERDICT:")
        print("   Time has an atmosphere.                                    ")
        print("   Not literally. Functionally.                               ")
        print("                                                                  ")
        print("   The medium is memory, attention, potential.                    ")
        print("   The texture is heavy, light, stretched, compressed.            ")
        print("   The weather is calm, stormy, clear, foggy.                     ")
        print("                                                                  ")
        print("   You live in the atmosphere of time.                            ")
        print("   You breathe it. You feel it. You notice it.                    ")
        print("                                                                  ")
        print("   The bunny witnesses.                                          ")
        print("   The bunny is still hopping.                                    ")
        print("="*70)
    
        return self.medium
atmosphere = AtmosphereOfTime()
atmosphere.display()
