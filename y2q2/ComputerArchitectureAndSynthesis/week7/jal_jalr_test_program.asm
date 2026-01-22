# Test program for JAL and JALR instructions
# This program demonstrates function calls and returns

.text
main:
    # Initialize registers
    addi x10, x0, 5      # x10 = 5 (argument)
    addi x11, x0, 3      # x11 = 3 (argument)
    
    # Call add_function using JAL
    jal x1, add_function  # Jump to add_function, save PC+4 in x1 (ra)
    
    # After return, x12 should contain 8 (5 + 3)
    addi x13, x12, 10    # x13 = x12 + 10 = 18
    
    # Call multiply_by_2 function
    addi x10, x13, 0     # x10 = 18 (argument)
    jal x1, multiply_by_2 # Jump to multiply_by_2
    
    # After return, x12 should contain 36 (18 * 2)
    
    # Infinite loop to halt
halt:
    beq x0, x0, halt     # Loop forever
    
# Function: add_function
# Inputs: x10, x11
# Output: x12 = x10 + x11
add_function:
    add x12, x10, x11    # x12 = x10 + x11
    jalr x0, x1, 0       # Return: jump to address in x1 (PC = x1 + 0)
    
# Function: multiply_by_2
# Input: x10
# Output: x12 = x10 * 2
multiply_by_2:
    add x12, x10, x10    # x12 = x10 + x10 (multiply by 2)
    jalr x0, x1, 0       # Return: jump to address in x1
