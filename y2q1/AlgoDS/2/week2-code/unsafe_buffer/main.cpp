#include <iostream>
#include <string>

int main() {
  size_t size;
  std::cin >> size;
  std::cin.ignore();

  char* buffer = new char[size]{};

  size_t head = 0;
  size_t tail = 0;
  size_t count = 0;

  std::string output;
  char ch;
  while (std::cin.get(ch)) {
    if (ch == '*') {
      if (count > 0) {
        output += buffer[head];
        head = (head + 1) % size;
        --count;
      }
    } else {
      buffer[tail] = ch;
      tail = (tail + 1) % size;
      if (count < size) {
        ++count;
      } else {
        head = (head + 1) % size;
      }
    }
  }
  std::cout << output << std::endl;
  delete[] buffer;
  return 0;
}
