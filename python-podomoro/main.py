import json
import os
from datetime import datetime

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
        print(f"✓ Added: {task['task']}")
    
    def list_tasks(self):
        """List all tasks"""
        if not self.todos:
            print("No tasks yet. Add some tasks!")
            return
        
        print("\n=== Your Tasks ===")
        for i, todo in enumerate(self.todos, 1):
            status = "✓" if todo['completed'] else "○"
            print(f"{i}. [{status}] {todo['task']}")
            if todo['completed']:
                print(f"   Created: {todo['created_at']}")
        print("==================\n")
    
    def complete_task(self, index):
        """Mark a task as completed"""
        if 1 <= index <= len(self.todos):
            self.todos[index - 1]['completed'] = True
            self.save_todos()
            print(f"✓ Completed: {self.todos[index - 1]['task']}")
        else:
            print(f"Invalid index: {index}")
    
    def delete_task(self, index):
        """Delete a task"""
        if 1 <= index <= len(self.todos):
            removed = self.todos.pop(index - 1)
            self.save_todos()
            print(f"✗ Deleted: {removed['task']}")
        else:
            print(f"Invalid index: {index}")
    
    def show_stats(self):
        """Show task statistics"""
        total = len(self.todos)
        completed = sum(1 for t in self.todos if t['completed'])
        pending = total - completed
        print(f"\n=== Statistics ===")
        print(f"Total tasks: {total}")
        print(f"Completed: {completed}")
        print(f"Pending: {pending}")
        if total > 0:
            print(f"Completion rate: {completed/total*100:.1f}%")
        print("==================\n")


def main():
    app = TodoApp()
    
    while True:
        print("\n=== To-Do App ===")
        print("1. Add task")
        print("2. List tasks")
        print("3. Complete task")
        print("4. Delete task")
        print("5. Show statistics")
        print("6. Exit")
        
        choice = input("\nEnter your choice (1-6): ").strip()
        
        if choice == '1':
            task = input("Enter task: ").strip()
            if task:
                app.add_task(task)
            else:
                print("Task cannot be empty!")
        
        elif choice == '2':
            app.list_tasks()
        
        elif choice == '3':
            app.list_tasks()
            index = input("Enter task number to complete: ").strip()
            if index:
                app.complete_task(int(index))
        
        elif choice == '4':
            app.list_tasks()
            index = input("Enter task number to delete: ").strip()
            if index:
                app.delete_task(int(index))
        
        elif choice == '5':
            app.show_stats()
        
        elif choice == '6':
            print("Goodbye! 🎉")
            break
        
        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()
