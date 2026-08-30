import time
import sys
from datetime import datetime

class PastaTimerApp:
    def __init__(self):
        self.pasta_options = {
            1: 'spaghetti',
            2: 'penne',
            3: 'fusilli',
            4: 'rigatoni',
            5: 'fettuccine',
            6: 'rotini',
            7: 'macaroni',
            8: 'lasagna'
        }
        
        self.cooking_times = {
            'spaghetti': {'al dente': 8, 'tender': 10, 'soft': 12},
            'penne':      {'al dente': 9, 'tender': 11, 'soft': 13},
            'fusilli':    {'al dente': 8, 'tender': 10, 'soft': 12},
            'rigatoni':   {'al dente': 9, 'tender': 11, 'soft': 13},
            'fettuccine': {'al dente': 7, 'tender': 9, 'soft': 11},
            'rotini':     {'al dente': 8, 'tender': 10, 'soft': 12},
            'macaroni':   {'al dente': 7, 'tender': 9, 'soft': 11},
            'lasagna':    {'al dente': 8, 'tender': 10, 'soft': 12}
        }
        
        self.doneness_levels = {
            'al dente': {'description': '🥢 Slightly firm to bite'},
            'tender':  {'description': '✅ Perfect softness'},
            'soft':    {'description': '🍖 Very soft/chewy'}
        }

    def clear_screen(self):
        """Clear the terminal screen"""
        print("\n" + "="*60)
        
    def display_header(self):
        """Display the beautiful header"""
        print("="*60)
        print("🍝" + " " * 58)
        print(" " + " ".ljust(60))
        print("🍝" + " " * 58)
        print(" " + "   🍝  PASTA COOKING TIMER".center(60))
        print(" " + " " * 58)
        print("🍝" + " " * 58)
        print(" " + " " * 58)
        print("="*60)
        print()
        
    def display_pasta_menu(self):
        """Display the numbered pasta menu"""
        self.clear_screen()
        self.display_header()
        print("📝 SELECT YOUR PASTA TYPE:")
        print("-" * 60)
        for num, pasta in self.pasta_options.items():
            print(f"   {num}. {pasta}")
        print("-" * 60)
        print()

    def display_doneness_menu(self):
        """Display the doneness options"""
        print("🥘 SELECT DONENESS LEVEL:")
        print("-" * 60)
        for level, info in self.doneness_levels.items():
            print(f"   {level.upper():<12} → {info['description']}")
        print("-" * 60)
        print()

    def get_user_input(self, title):
        """Get user input with timeout"""
        print(f"{title}")
        try:
            return input("> ").strip()
        except EOFError:
            print("\n👋 Exiting...")
            sys.exit(0)

    def select_pasta(self):
        """Select pasta with numbered menu"""
        print()
        self.display_pasta_menu()
        try:
            while True:
                choice = self.get_user_input("Enter number (1-8): ")
                if not choice:
                    continue
                choice = int(choice)
                if 1 <= choice <= 8:
                    return self.pasta_options[choice]
                else:
                    print("❌ Invalid number! Please enter 1-8.")
        except ValueError:
            print("❌ Please enter a valid number.")

    def select_donteness(self, pasta_type):
        """Select doneness level"""
        print(f"\n🍽️  Now select texture for {pasta_type}:")
        self.display_doneness_menu()
        
        try:
            while True:
                choice = self.get_user_input("Enter 1 (al dente), 2 (tender), or 3 (soft): ")
                if not choice:
                    continue
                try:
                    number = int(choice)
                    if number == 1:
                        return 'al dente'
                    elif number == 2:
                        return 'tender'
                    elif number == 3:
                        return 'soft'
                    else:
                        print("❌ Invalid! Please enter 1, 2, or 3.")
                except ValueError:
                    print("❌ Please enter a number.")
        except KeyboardInterrupt:
            print("\n\n👋 Exiting...")
            sys.exit(0)

    def get_cooking_time(self, pasta_type, doneness_level):
        """Get cooking time for specific pasta and doneness"""
        # Use the doneness level as a string key
        if pasta_type in self.cooking_times:
            if doneness_level in self.cooking_times[pasta_type]:
                return self.cooking_times[pasta_type][doneness_level]
        return 10  # Default time

    def display_timer(self, pasta_type, doneness_level, duration_minutes):
        """Display the countdown timer"""
        print("\n" + "="*60)
        print(f"🍝 COOKING {pasta_type.upper()} 🍝")
        print("="*60)
        print(f"📖 Doneness: {doneness_level}")
        print(f"⏱️  Time: {duration_minutes} minutes")
        print("="*60)
        
        start_time = time.time()
        
        try:
            while duration_minutes > 0:
                remaining = round((duration_minutes * 60) - (time.time() - start_time), 1)
                
                if remaining > 0:
                    minutes = int(remaining // 60)
                    seconds = int(remaining % 60)
                    print(f"\r⏱️  {minutes:02d}:{seconds:02d}  ⏱️", end='', flush=True)
                    time.sleep(1)
                else:
                    print(f"\r⏱️  00:00  ⏱️", end='', flush=True)
                    print(f"\n\n🎉 PASTA IS READY! Enjoy your {pasta_type}!")
                    print(f"⏱️  Cooking time completed in {duration_minutes} minutes.")
                    print("="*60)
                    return
        except KeyboardInterrupt:
            print("\n\n⚠️  Timer cancelled. Remove from water manually.")
            print("="*60)

    def display_recipe_tips(self, pasta_type):
        """Display helpful cooking tips"""
        print("\n💡 COOKING TIPS:")
        print("-" * 60)
        tips = {
            'spaghetti': "Salt the water well!",
            'penne': "Rinse only if very thick pasta.",
            'fusilli': "Add a splash of pasta water.",
            'rigatoni': "Save pasta water for sauce!",
            'fettuccine': "Cook in plenty of water.",
            'rotini': "Add vegetables after pasta.",
            'macaroni': "Cook slightly less than package.",
            'lasagna': "Use boiling water only."
        }
        if pasta_type in tips:
            print(f"   ✨ {tips[pasta_type]}")
        else:
            print("   ✨ Always taste before finishing!")
        print("-" * 60)

    def run(self):
        """Run the main app"""
        self.clear_screen()
        self.display_header()
        print("🍝 Welcome to the Pasta Cooking Timer!")
        print()
        
        pasta_type = self.select_pasta()
        doneness_level = self.select_donteness(pasta_type)
        cooking_time = self.get_cooking_time(pasta_type, doneness_level)
        self.display_recipe_tips(pasta_type)
        
        print("\n⏰ Starting timer...")
        self.display_timer(pasta_type, doneness_level, cooking_time)
        
        print("\n" + "="*60)
        print("🎊 HAPPY COOKING! Enjoy your meal! 🎊")
        print("="*60)

if __name__ == "__main__":
    app = PastaTimerApp()
    app.run()
