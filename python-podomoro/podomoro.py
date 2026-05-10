
import time
import sys
import os
import signal
import argparse
from datetime import datetime, timedelta
from collections import deque
import threading
from typing import Optional

# Terminal color codes
class Colors:
    RESET = '\033[0m'
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    MAGENTA = '\033[95m'
    CYAN = '\033[96m'
    WHITE = '\033[97m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

# Terminal size helper
def get_terminal_size():
    try:
        rows, columns = os.popen('stty size', 'r').read().split()
        return int(rows), int(columns)
    except:
        return 24, 80

# Pomodoro Timer Class
class PomodoroTimer:
    def __init__(self, work_minutes=25, break_minutes=5, long_break_minutes=15, 
                 long_break_interval=4, auto_start=True):
        self.work_minutes = work_minutes
        self.break_minutes = break_minutes
        self.long_break_minutes = long_break_minutes
        self.long_break_interval = long_break_interval
        self.auto_start = auto_start
        
        self.work_seconds = work_minutes * 60
        self.break_seconds = break_minutes * 60
        self.long_break_seconds = long_break_minutes * 60
        
        self.state = "work"  # work, break, long_break
        self.time_left = self.work_seconds
        self.session_count = 0
        self.is_running = False
        self.is_paused = False
        self.is_stopped = False
        self.history = deque(maxlen=20)
        self.stats = {
            'work_sessions': 0,
            'break_sessions': 0,
            'long_breaks': 0,
            'total_time': 0
        }
        self.start_time = None
        self.last_update = time.time()
        
        # Initialize with a default session
        self.reset_session()
        
    def reset_session(self):
        self.time_left = self.work_seconds
        self.state = "work"
        self.is_running = False
        self.is_paused = False
        self.is_stopped = False
        self.start_time = time.time()
        self.last_update = time.time()
        
    def start(self):
        if not self.is_running:
            self.is_running = True
            self.is_paused = False
            self.is_stopped = False
            self.start_time = time.time()
            self.last_update = time.time()
            
    def pause(self):
        if self.is_running and not self.is_paused:
            self.is_paused = True
            self.is_running = False
            
    def resume(self):
        if self.is_paused:
            self.is_paused = False
            self.is_running = True
            self.start_time = time.time() - (self.start_time - self.start_time)
            self.last_update = time.time()
            
    def stop(self):
        self.is_running = False
        self.is_paused = False
        self.is_stopped = True
        
    def skip(self):
        self.stop()
        self.next_session()
        
    def next_session(self):
        if self.state == "work":
            self.session_count += 1
            self.stats['work_sessions'] += 1
            if self.session_count % self.long_break_interval == 0:
                self.state = "long_break"
                self.time_left = self.long_break_seconds
                self.stats['long_breaks'] += 1
            else:
                self.state = "break"
                self.time_left = self.break_seconds
                self.stats['break_sessions'] += 1
        else:
            self.state = "work"
            self.time_left = self.work_seconds
            
        self.is_running = False
        self.is_paused = False
        self.is_stopped = False
        self.start_time = time.time()
        self.last_update = time.time()
        
    def update(self):
        if self.is_running and not self.is_paused:
            current_time = time.time()
            elapsed = current_time - self.last_update
            self.last_update = current_time
            
            if self.time_left > 0:
                self.time_left = max(0, self.time_left - elapsed)
            else:
                # Session completed
                self.stats['total_time'] += self.work_seconds if self.state == "work" else self.break_seconds
                self.next_session()
                
    def get_time_string(self):
        minutes, seconds = divmod(int(self.time_left), 60)
        return f"{minutes:02d}:{seconds:02d}"
        
    def get_state_string(self):
        state_str = ""
        if self.state == "work":
            state_str = "WORK"
        elif self.state == "break":
            state_str = "BREAK"
        else:
            state_str = "LONG BREAK"
            
        if self.is_paused:
            return f"{state_str} (PAUSED)"
        elif not self.is_running:
            return f"{state_str} (STOPPED)"
        return state_str
            
    def get_progress_bar(self, width=30):
        if self.state == "work":
            color = Colors.GREEN
        elif self.state == "break":
            color = Colors.BLUE
        else:
            color = Colors.MAGENTA
            
        total = self.work_seconds if self.state == "work" else self.break_seconds if self.state == "break" else self.long_break_seconds
        progress = (total - self.time_left) / total if total > 0 else 0
        filled_width = int(progress * width)
        bar = "█" * filled_width + "░" * (width - filled_width)
        return f"{color}{bar}{Colors.RESET}"
        
    def get_stats_string(self):
        return (f"Sessions: {self.session_count} | "
                f"Work: {self.stats['work_sessions']} | "
                f"Break: {self.stats['break_sessions']} | "
                f"Long: {self.stats['long_breaks']} | "
                f"Total: {self.stats['total_time'] // 60}m")

# TUI Interface
class PomodoroTUI:
    def __init__(self, timer: PomodoroTimer):
        self.timer = timer
        self.running = True
        self.terminal_rows, self.terminal_columns = get_terminal_size()
        
        # Setup signal handling for graceful exit
        signal.signal(signal.SIGINT, self.handle_exit)
        signal.signal(signal.SIGTERM, self.handle_exit)
        
    def handle_exit(self, signum, frame):
        self.running = False
        print("\nExiting Pomodoro Timer...")
        sys.exit(0)
        
    def clear_screen(self):
        os.system('clear' if os.name == 'posix' else 'cls')
        
    def draw_header(self):
        header = f"{Colors.BOLD}{Colors.CYAN}POMODORO TIMER{Colors.RESET}"
        print(f"{header:^{self.terminal_columns}}")
        print(f"{'=' * self.terminal_columns}")
        
    def draw_timer(self):
        # Timer display
        time_str = self.timer.get_time_string()
        state_str = self.timer.get_state_string()
        
        # Determine color based on state
        if self.timer.state == "work":
            color = Colors.RED
            state_color = Colors.RED
        elif self.timer.state == "break":
            color = Colors.GREEN
            state_color = Colors.GREEN
        else:
            color = Colors.MAGENTA
            state_color = Colors.MAGENTA
            
        # Timer box
        print(f"\n{state_color}{Colors.BOLD}{state_str}{Colors.RESET}")
        print(f"{color}{Colors.BOLD}{time_str}{Colors.RESET}")
        print(f"{self.timer.get_progress_bar(30)}")
        
    def draw_controls(self):
        print("\nControls:")
        print("  [Space] Start/Pause")
        print("  [S] Skip session")
        print("  [R] Reset")
        print("  [Q] Quit")
        print("  [H] Help")
        
    def draw_stats(self):
        print(f"\n{Colors.BOLD}Statistics:{Colors.RESET}")
        print(f"  {self.timer.get_stats_string()}")
        
    def draw_history(self):
        print(f"\n{Colors.BOLD}Recent Sessions:{Colors.RESET}")
        if not self.timer.history:
            print("  No sessions completed yet")
        else:
            for i, session in enumerate(list(self.timer.history)[-5:], 1):
                print(f"  {i}. {session}")
                
    def draw_help(self):
        print(f"\n{Colors.BOLD}Help:{Colors.RESET}")
        print("  The Pomodoro Technique uses 25-minute work sessions followed by 5-minute breaks")
        print("  After 4 work sessions, you take a longer 15-minute break")
        print("  This helps maintain focus and prevent burnout")
        print("\nControls:")
        print("  Space: Start/Pause timer")
        print("  S: Skip current session")
        print("  R: Reset timer")
        print("  Q: Quit")
        print("  H: Show this help")
        print("\nPress any key to return to timer...")
        sys.stdin.read(1)

    def draw(self):
        self.clear_screen()
        self.draw_header()
        self.draw_timer()
        self.draw_controls()
        self.draw_stats()
        self.draw_history()

    def run(self):
        import select
        import tty
        import termios

        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)

        try:
            tty.setcbreak(fd)
            if self.timer.auto_start:
                self.timer.start()

            while self.running:
                self.draw()
                self.timer.update()

                # Non-blocking wait for input or 0.1s timeout
                dr, dw, de = select.select([sys.stdin], [], [], 0.1)
                if dr:
                    key = sys.stdin.read(1)
                    if key.lower() == ' ':
                        if self.timer.is_running:
                            self.timer.pause()
                        elif self.timer.is_stopped or not self.timer.is_paused:
                            self.timer.start()
                        else:
                            self.timer.resume()
                    elif key.lower() == 's':
                        self.timer.skip()
                    elif key.lower() == 'r':
                        self.timer.reset_session()
                    elif key.lower() == 'q':
                        self.running = False
                    elif key.lower() == 'h':
                        self.draw_help()
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

        print("\nTimer stopped. Goodbye!")

# Main function
def main():
    parser = argparse.ArgumentParser(description='Pomodoro Timer with TUI')
    parser.add_argument('--work', type=int, default=25, help='Work session duration in minutes (default: 25)')
    parser.add_argument('--short-break', type=int, default=5, help='Short break duration in minutes (default: 5)')
    parser.add_argument('--long-break', type=int, default=15, help='Long break duration in minutes (default: 15)')
    parser.add_argument('--long-interval', type=int, default=4, help='Number of work sessions before long break (default: 4)')
    parser.add_argument('--no-auto-start', action='store_true', help='Do not auto-start the timer')
    
    args = parser.parse_args()
    
    # Create timer with arguments
    timer = PomodoroTimer(
        work_minutes=args.work,
        break_minutes=args.short_break,
        long_break_minutes=args.long_break,
        long_break_interval=args.long_interval,
        auto_start=not args.no_auto_start
    )
    
    # Create and run TUI
    tui = PomodoroTUI(timer)
    tui.run()

if __name__ == "__main__":
    main()
