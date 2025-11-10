
#include "linked_list.h"
#include <iostream>

int main() {
  sax::linked_list_node<std::string> *head = nullptr;
  std::cin >> head;
  std::string element;

  if (!std::cin) {
    std::cerr << "err read list from input" << std::endl;
sax::linked_list_node<std::string>::cleanup(head);
    return 1;
  }

  std::cin >> element;

  
  if (head == nullptr) {
    head = new sax::linked_list_node<std::string>{element};
  } else {
    
    bool exists = false;
    for (auto *cur = head; cur != nullptr; cur = cur->next) {
      if (cur->data == element) {
        exists = true;
        break;
      }
    }

    if (!exists) {
      auto *new_node = new sax::linked_list_node<std::string>{element};

      
      if (element < head->data) {
        new_node->next = head;
        head = new_node;
      } 
      
      else {
        sax::linked_list_node<std::string> *current = head;
        while (current->next != nullptr && current->next->data < element) {
          current = current->next;
        }
        new_node->next = current->next;
        current->next = new_node;
      }
    }
  }

  std::cout << head << std::endl;

  sax::linked_list_node<std::string>::cleanup(head);
  return 0;
}
