#include <array>
#include <cctype>
#include <cstddef>
#include <iostream>
#include <string>
#include <vector>

std::string to_lower(const std::string &s) {
  std::string processed = s;
  for (char &ch : processed) 
    ch = std::tolower(ch);
  return processed;
}
bool valid_char(char ch) {
  return std::islower(ch);
}

std::array<int, 26> calculate_needed_freq(const std::string &sentence) {
  std::array<int, 26> processed = {};
  for (char ch : sentence)
    if (valid_char(ch))
      processed[ch - 'a']++;
  return processed;
}


std::string find_anagram(const std::string &text, const std::string &sentence) {
  std::array<int, 26> needed_freq = calculate_needed_freq(sentence);
  std::array<int, 26> current_freq = {};
  
  size_t k = 0;
  for (char ch : sentence) {
    if (valid_char(ch)) {
      k++;
    }
  }

  std::vector<int> letter_indices;

  for (size_t i = 0; i < text.size(); i++) {
    char ch = text[i];
    if (!valid_char(ch)) {
      continue;
    } 

    current_freq[ch - 'a']++;
    letter_indices.push_back(i);
    
    if (letter_indices.size() > k) {
      char left_ch = text[letter_indices[letter_indices.size() - k - 1]];
      current_freq[left_ch - 'a']--;
    }

    if (letter_indices.size() >= k && current_freq == needed_freq) {
      int start_idx = letter_indices[letter_indices.size() - k];
      int end_idx = i;
      return text.substr(start_idx, end_idx - start_idx + 1);
    }
  }

  return "<not found>";
}

int main() {
  std::string sentence;
  std::string text;
 allude briefly to th
  std::getline(std::cin, sentence);
  std::getline(std::cin, text);

  sentence = to_lower(sentence);
  text = to_lower(text);

  std::cout << find_anagram(text, sentence);
  return 0;


}
