.text
.globl main
main:
    li  x16, 4              # Array size (n) = 4
    li  x15, 0x1000         # Base address of array
    li  x28, 23
    sw  x28, 0(x15)         # c[0] = 23
    li  x28, 12
    sw  x28, 4(x15)         # c[1] = 12
    li  x28, 5
    sw  x28, 8(x15)         # c[2] = 5
    li  x28, 44
    sw  x28, 12(x15)        # c[3] = 44

DowhileLoop:
    li  x18, 0              # flag = 0
    li  x17, 1              # i = 1

ForLoop:
    bge  x17, x16, ForLoopExit # If i >= n, exit the for loop
    slli x28, x17, 2        # Offset = i * 4
    add  x28, x15, x28      # x28 = Address of c[i]
    addi x29, x28, -4       # x29 = Address of c[i-1]
    lw   x30, 0(x29)        # x30 = c[i-1]
    lw   x31, 0(x28)        # x31 = c[i]
    bge  x31, x30, NoSwap   # If c[i] >= c[i-1], skip the swap
    sw   x30, 0(x28)        # Store c[i-1]'s value into c[i]
    sw   x31, 0(x29)        # Store c[i]'s value into c[i-1]
    li   x18, 1             # flag = 1 (A swap occurred!)

NoSwap:
    addi x17, x17, 1        # i++
    j    ForLoop            # Jump back to top of ForLoop

ForLoopExit:
    beq x18, x0, ExitSort  # If flag == 0 (no swaps)
    j DowhileLoop        # If flag == 1 (swaps happened)

ExitSort:
    j ExitSort