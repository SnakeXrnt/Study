---
title: "README"
author: "Course Instructors"
date: "2025-09-05"
---
# Conversion to PDF

To convert your markdown, simply invoke `pandoc` as follows (if you don't like the output and want to customize it, feel free to do so & let the teachers know so that the templates / styles can be reused by others!):

```verbose
pandoc -o output.pdf input.md
```

To test whether the conversion was successful, you can open the `output.pdf` file in a PDF reader and verify that the content is displayed correctly.
Make sure to use three backticks (```) followed by the language identifier (e.g., `c` or `cpp`) to enclose your code blocks.

```c
#include <stdio.h>

int main(void) {
    printf("Hello, World!\n");
    return 0;
}
```

```cpp
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```
