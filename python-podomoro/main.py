import json
import os
import curses
from datetime import datetime
from collections import deque

class TodoApp:
    def __init__(self, filename="todos.json"):
        self.filename = filename
        self.todos = []
        self.load_todos()
    
    def load_todos(self):
        """Load todos from file"""
        if os.path.exists(self.filename):
            try:
                with open(self.filename, 'r') as f:
                    self.todos = json.load(f)
            except (json.JSONDecodeError, IOError):
                self.todos = []
    
    def save_todos(self):
        """Save todos to file"""
        with open(self.filename, 'w') as f:
            json.dump(self.todos, f, indent=2)
    
    def add_task(self, task):
        """Add a new task"""
        task = {
            'task': task,
            'completed': False,
            'created_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        self.todos.append(task)
        self.save_todos()
        return True
    
    def complete_task(self, index):
        """Mark a task as completed"""
        if 1 <= index <= len(self.todos):
            self.todos[index - 1]['completed'] = True
            self.save_todos()
            return True
        return False
    
    def delete_task(self, index):
        """Delete a task"""
        if 1 <= index <= len(self.todos):
            removed = self.todos.pop(index - 1)
            self.save_todos()
            return True
        return False
    
    def show_stats(self):
        """Show task statistics"""
        total = len(self.todos)
        completed = sum(1 for t in self.todos if t['completed'])
        pending = total - completed
        return {
            'total': total,
            'completed': completed,
            'pending': pending,
            'completion_rate': (completed/total*100) if total > 0 else 0
        }


def clear_screen(stdscr):
    """Clear the screen"""
    stdscr.clear()
    stdscr.refresh()


def draw_header(stdscr, stats):
    """Draw the header with stats"""
    stdscr.attron(curses.color_pair(1) | curses.A_BOLD)
    stdscr.addstr(0, 0, "╔" + "═" * (curses.COLS - 2) + "╗")
    stdscr.addstr(0, 1, "  📝 PODOMORO TO-DO APP  ")
    stdscr.addstr(0, curses.COLS - 15, "╚" + "═" * (curses.COLS - 2) + "╝")
    stdscr.attroff(curses.color_pair(1) | curses.A_BOLD)
    
    stdscr.attron(curses.color_pair(2))
    stdscr.addstr(1, 0, f"  📊 Total: {stats['total']} | ✅ Done: {stats['completed']} | ⏳ Pending: {stats['pending']}")
    stdscr.addstr(2, 0, f"  📈 Completion Rate: {stats['completion_rate']:.1f}%")
    stdscr.attroff(curses.color_pair(2))


def draw_tasks(stdscr, todos, y_offset=3):
    """Draw the task list"""
    for i, todo in enumerate(todos):
        y = y_offset + i
        if y >= stdscr.getmaxyx()[0] - 3:
            break
        
        status = "✅" if todo['completed'] else "⏳"
        task_text = todo['task']
        
        # Truncate long task names
        max_width = curses.COLS - 4
        if len(task_text) > max_width:
            task_text = task_text[:max_width - 3] + "..."
        
        stdscr.attron(curses.color_pair(3) if todo['completed'] else curses.color_pair(4))
        stdscr.addstr(y, 0, f"  {status} {task_text}")
        stdscr.attroff(curses.color_pair(3) if todo['completed'] else curses.color_pair(4))
        
        if todo['completed']:
            stdscr.addstr(y + 1, 0, f"     Created: {todo['created_at']}")


def draw_footer(stdscr, todos, current_index):
    """Draw the footer with navigation instructions"""
    y = stdscr.getmaxyx()[0] - 2
    
    # Navigation instructions
    stdscr.attron(curses.color_pair(5))
    stdscr.addstr(y, 0, "  🖱️  UP/DOWN: Navigate | SPACE: Toggle Complete | DEL: Delete | Q: Quit")
    stdscr.attroff(curses.color_pair(5))
    
    # Current selection
    if current_index is not None and 0 <= current_index < len(todos):
        stdscr.attron(curses.color_pair(6) | curses.A_REVERSE)
        stdscr.addstr(y + 1, 0, f"  → Selected: {todos[current_index]['task']}")
        stdscr.attroff(curses.color_pair(6) | curses.A_REVERSE)
    else:
        stdscr.addstr(y + 1, 0, "  → No tasks selected")


def draw_welcome(stdscr):
    """Draw welcome screen"""
    stdscr.clear()
    stdscr.attron(curses.color_pair(1) | curses.A_BOLD | curses.A_BLINK)
    welcome_text = [
        "  ╔════════════════════════════════════════╗",
        "  ║           📝 PODOMORO TO-DO APP        ║",
        "  ║                                        ║",
        "  ║  Welcome! Press 'Q' to quit anytime.   ║",
        "  ║                                        ║",
        "  ║  Press 'A' to add a new task.          ║",
        "  ╚════════════════════════════════════════╝"
    ]
    for i, line in enumerate(welcome_text):
        stdscr.addstr(i + 1, 0, line)
    stdscr.attroff(curses.color_pair(1) | curses.A_BOLD | curses.A_BLINK)
    stdscr.refresh()


def main(stdscr):
    """Main application function"""
    # Initialize colors
    curses.start_color()
    curses.use_default_colors()
    curses.init_pair(1, curses.COLOR_CYAN, -1)   # Header
    curses.init_pair(2, curses.COLOR_YELLOW, -1) # Stats
    curses.init_pair(3, curses.COLOR_GREEN, -1)  # Completed tasks
    curses.init_pair(4, curses.COLOR_WHITE, -1)  # Pending tasks
    curses.init_pair(5, curses.COLOR_MAGENTA, -1) # Instructions
    curses.init_pair(6, curses.COLOR_BLACK, curses.COLOR_WHITE) # Selection
    
    # Initialize app
    app = TodoApp()
    stats = app.show_stats()
    
    # Draw welcome screen
    draw_welcome(stdscr)
    
    # Wait a moment before showing main screen
    curses.napms(500)
    
    # Main loop
    current_index = 0
    running = True
    
    while running:
        clear_screen(stdscr)
        
        # Draw header
        draw_header(stdscr, stats)
        
        # Draw tasks
        draw_tasks(stdscr, app.todos, y_offset=3)
        
        # Draw footer
        draw_footer(stdscr, app.todos, current_index)
        
        stdscr.refresh()
        
        # Handle input
        key = stdscr.getch()
        
        if key == ord('q') or key == ord('Q'):
            running = False
        
        elif key == ord('a') or key == ord('A'):
            # Add new task
            stdscr.clear()
            stdscr.attron(curses.color_pair(1) | curses.A_BOLD)
            stdscr.addstr(0, 0, "  📝 Add New Task")
            stdscr.addstr(1, 0, "  ═════════════════")
            stdscr.attroff(curses.color_pair(1) | curses.A_BOLD)
            stdscr.refresh()
            
            # Get input
            task_input = ""
            while True:
                stdscr.clear()
                draw_header(stdscr, stats)
                draw_tasks(stdscr, app.todos, y_offset=3)
                draw_footer(stdscr, app.todos, current_index)
                
                stdscr.attron(curses.color_pair(4))
                stdscr.addstr(3, 0, "  Enter task name: ")
                stdscr.attroff(curses.color_pair(4))
                
                stdscr.refresh()
                
                ch = stdscr.getch()
                
                if ch == 27:  # ESC
                    stdscr.clear()
                    draw_header(stdscr, stats)
                    draw_tasks(stdscr, app.todos, y_offset=3)
                    draw_footer(stdscr, app.todos, current_index)
                    stdscr.refresh()
                    break
                
                elif ch == 10 or ch == curses.KEY_ENTER:  # Enter
                    if task_input.strip():
                        app.add_task(task_input.strip())
                        stdscr.clear()
                        draw_header(stdscr, stats)
                        draw_tasks(stdscr, app.todos, y_offset=3)
                        draw_footer(stdscr, app.todos, current_index)
                        stdscr.refresh()
                        break
                    else:
                        stdscr.addstr(3, 20, "  Task cannot be empty!")
                        stdscr.refresh()
                
                elif ch == curses.KEY_BACKSPACE or ch == 127:
                    task_input = task_input[:-1]
                
                elif 32 <= ch <= 126:  # Printable characters
                    task_input += chr(ch)
                
                stdscr.addstr(3, 20, task_input)
                stdscr.refresh()
        
        elif key == curses.KEY_UP:
            if current_index > 0:
                current_index -= 1
        
        elif key == curses.KEY_DOWN:
            if current_index < len(app.todos) - 1:
                current_index += 1
        
        elif key == ord(' '):  # Space - toggle complete
            if 0 <= current_index < len(app.todos):
                app.todos[current_index]['completed'] = not app.todos[current_index]['completed']
                app.save_todos()
        
        elif key == ord('d') or key == ord('D'):  # Delete
            if 0 <= current_index < len(app.todos):
                app.delete_task(current_index + 1)
                app.save_todos()
                current_index = max(0, current_index - 1)
    
    # Exit cleanly
    curses.endwin()


if __name__ == "__main__":
    curses.wrapper(main)
