import curses
import math
import sys

class ScientificCalculator:
    def __init__(self):
        self.expression = ""
        self.result = ""
        self.history = []
        self.operations = {
            'sin': math.sin,
            'cos': math.cos,
            'tan': math.tan,
            'asin': math.asin,
            'acos': math.acos,
            'atan': math.atan,
            'log': math.log10,
            'ln': math.log,
            'sqrt': math.sqrt,
            'pow': lambda x, y: x ** y,
            'pi': math.pi,
            'e': math.e
        }
    
    def clear(self):
        self.expression = ""
        self.result = ""
    
    def append(self, char):
        if char in ['+', '-', '*', '/', '(', ')', '.', '^', '%']:
            if char == '.' and '.' in self.expression:
                return
            if char in ['+', '-', '*', '/', '^', '%'] and self.expression and self.expression[-1] in ['+', '-', '*', '/', '^', '%']:
                return
        self.expression += char
    
    def calculate(self):
        try:
            # Replace operations with Python equivalents
            expr = self.expression.replace('^', '**')
            expr = expr.replace('π', 'pi')
            expr = expr.replace('e', 'e')
            
            # Handle functions
            for func, method in self.operations.items():
                if func in self.expression:
                    expr = expr.replace(func, f'({method.__name__})')
            
            # Evaluate safely
            result = eval(expr, {"__builtins__": {}}, {"pi": math.pi, "e": math.e, "sin": math.sin, "cos": math.cos, "tan": math.tan, "asin": math.asin, "acos": math.acos, "atan": math.atan, "log": math.log10, "ln": math.log, "sqrt": math.sqrt, "pow": lambda x, y: x ** y})
            
            self.result = str(result)
            self.history.append(self.expression)
            return True
        except Exception as e:
            self.result = "Error"
            return False
    
    def get_operations(self):
        return list(self.operations.keys())

def main(stdscr):
    calc = ScientificCalculator()
    
    # Setup curses
    curses.curs_set(0)  # Hide cursor
    stdscr.nodelay(1)  # Non-blocking input
    stdscr.timeout(100)  # 100ms timeout for getch
    
    # Initialize colors
    curses.start_color()
    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE)
    curses.init_pair(2, curses.COLOR_CYAN, curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_RED, curses.COLOR_BLACK)
    
    # Main loop
    while True:
        # Clear screen
        stdscr.clear()
        
        # Title
        stdscr.addstr(0, 0, " " * 80)
        stdscr.addstr(0, 0, "SCIENTIFIC CALCULATOR", curses.color_pair(2) | curses.A_BOLD)
        stdscr.addstr(1, 0, " " * 80)
        
        # Display expression
        stdscr.addstr(3, 0, "Expression: " + calc.expression.ljust(70))
        
        # Display result
        if calc.result:
            stdscr.addstr(5, 0, "Result: " + calc.result.ljust(70), curses.color_pair(3))
        
        # Display history
        stdscr.addstr(7, 0, "History:")
        for i, h in enumerate(calc.history[-5:]):
            stdscr.addstr(8 + i, 0, f"  {h}")
        
        # Display operations
        stdscr.addstr(12, 0, "Operations:")
        ops = calc.get_operations()
        for i, op in enumerate(ops):
            stdscr.addstr(13 + i, 0, f"  {op}: {calc.operations[op]}")
        
        # Display instructions
        stdscr.addstr(20, 0, "Controls: Arrow keys to navigate | Enter to calculate | Esc to quit | Mouse to click")
        
        # Draw buttons
        stdscr.addstr(22, 0, "Buttons:")
        buttons = [
            ['7', '8', '9', '/'],
            ['4', '5', '6', '*'],
            ['1', '2', '3', '-'],
            ['0', '.', 'C', '+'],
            ['sin', 'cos', 'tan', '^'],
            ['log', 'ln', 'sqrt', 'pi']
        ]
        
        for row_idx, row in enumerate(buttons):
            for col_idx, btn in enumerate(row):
                x = 2 + col_idx * 10
                y = 22 + row_idx
                stdscr.addstr(y, x, btn.ljust(8), curses.color_pair(1))
        
        # Draw calculate button
        stdscr.addstr(28, 0, "CALCULATE", curses.color_pair(2) | curses.A_BOLD)
        
        # Draw quit button
        stdscr.addstr(29, 0, "QUIT", curses.color_pair(4) | curses.A_BOLD)
        
        # Draw clear button
        stdscr.addstr(30, 0, "CLEAR", curses.color_pair(4) | curses.A_BOLD)
        
        # Refresh screen
        stdscr.refresh()
        
        # Get input
        key = stdscr.getch()
        
        if key == -1:
            continue
        
        # Handle keyboard input
        if key == 27:  # ESC
            break
        
        elif key == curses.KEY_ENTER or key == 10 or key == 13:
            calc.calculate()
        
        elif key == curses.KEY_BACKSPACE or key == 127 or key == 8:
            calc.expression = calc.expression[:-1]
        
        elif key == curses.KEY_LEFT:
            if calc.expression:
                calc.expression = calc.expression[:-1]
        
        elif key == curses.KEY_RIGHT:
            if calc.expression:
                calc.expression += ' '
        
        elif key == curses.KEY_UP:
            pass
        
        elif key == curses.KEY_DOWN:
            pass
        
        # Handle numeric input
        elif key >= ord('0') and key <= ord('9'):
            calc.append(chr(key))
        
        # Handle special characters
        elif key == ord('+'):
            calc.append('+')
        elif key == ord('-'):
            calc.append('-')
        elif key == ord('*'):
            calc.append('*')
        elif key == ord('/'):
            calc.append('/')
        elif key == ord('('):
            calc.append('(')
        elif key == ord(')'):
            calc.append(')')
        elif key == ord('^'):
            calc.append('^')
        elif key == ord('%'):
            calc.append('%')
        elif key == ord('.'):
            calc.append('.')
        
        # Handle function buttons
        elif key == ord('s'):
            calc.append('sin(')
        elif key == ord('c'):
            calc.append('cos(')
        elif key == ord('t'):
            calc.append('tan(')
        elif key == ord('l'):
            calc.append('log(')
        elif key == ord('n'):
            calc.append('ln(')
        elif key == ord('r'):
            calc.append('sqrt(')
        elif key == ord('p'):
            calc.append('pi')
        elif key == ord('e'):
            calc.append('e')
        
        # Handle mouse clicks
        elif key == curses.KEY_MOUSE:
            try:
                mouse_x, mouse_y, _, _, _ = curses.getmouse()
                
                # Check if clicked on buttons
                if 22 <= mouse_y <= 30:
                    if 2 <= mouse_x <= 10:
                        calc.append('7')
                    elif 12 <= mouse_x <= 20:
                        calc.append('8')
                    elif 22 <= mouse_x <= 30:
                        calc.append('9')
                    elif 32 <= mouse_x <= 40:
                        calc.append('/')
                    elif 42 <= mouse_x <= 50:
                        calc.append('4')
                    elif 52 <= mouse_x <= 60:
                        calc.append('5')
                    elif 62 <= mouse_x <= 70:
                        calc.append('6')
                    elif 72 <= mouse_x <= 80:
                        calc.append('*')
                    elif 82 <= mouse_x <= 90:
                        calc.append('1')
                    elif 92 <= mouse_x <= 100:
                        calc.append('2')
                    elif 102 <= mouse_x <= 110:
                        calc.append('3')
                    elif 112 <= mouse_x <= 120:
                        calc.append('-')
                    elif 122 <= mouse_x <= 130:
                        calc.append('0')
                    elif 132 <= mouse_x <= 140:
                        calc.append('.')
                    elif 142 <= mouse_x <= 150:
                        calc.append('C')
                        calc.clear()
                    elif 152 <= mouse_x <= 160:
                        calc.append('sin(')
                    elif 162 <= mouse_x <= 170:
                        calc.append('cos(')
                    elif 172 <= mouse_x <= 180:
                        calc.append('tan(')
                    elif 182 <= mouse_x <= 190:
                        calc.append('^')
                    elif 192 <= mouse_x <= 200:
                        calc.append('log(')
                    elif 202 <= mouse_x <= 210:
                        calc.append('ln(')
                    elif 212 <= mouse_x <= 220:
                        calc.append('sqrt(')
                    elif 222 <= mouse_x <= 230:
                        calc.append('pi')
                    elif 232 <= mouse_x <= 240:
                        calc.append('e')
                    elif 242 <= mouse_x <= 250:
                        calc.calculate()
                    elif 252 <= mouse_x <= 260:
                        calc.clear()
                        calc.expression = ""
                        calc.result = ""
            except curses.error:
                pass
        
        # Handle quit button
        elif key == ord('q'):
            break
        
        # Handle clear button
        elif key == ord('c'):
            calc.clear()
            calc.expression = ""
            calc.result = ""

if __name__ == "__main__":
    try:
        curses.wrapper(main)
    except KeyboardInterrupt:
        print("\nCalculator exited.")
        sys.exit(0)
