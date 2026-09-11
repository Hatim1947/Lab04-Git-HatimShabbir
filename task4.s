.text
.globl main

main:
    # Set up test array at memory address 0x1000
    li   s0, 0x1000             # s0 = Base address of array
    li   t0, 15; sw t0, 0(s0)   # arr[0] = 15
    li   t0, 42; sw t0, 4(s0)   # arr[1] = 42
    li   t0, 8;  sw t0, 8(s0)   # arr[2] = 8
    li   t0, 27; sw t0, 12(s0)  # arr[3] = 27

    # Pass parameters to recursive procedure
    mv   a0, s0                 # a0 = Array base address
    li   a1, 4                  # a1 = Array length (n = 4)
    jal  ra, find_array_max_rec # Call recursive function

Exit:
    j    Exit                   # Infinite loop to terminate program


find_array_max_rec:
    # Stack frame allocation & register saving
    addi sp, sp, -16            # Allocate space on stack frame
    sw   ra, 12(sp)             # Save return address
    sw   s0, 8(sp)              # Save s0 (array base address)
    sw   s1, 4(sp)              # Save s1 (array size n)
    sw   s2, 0(sp)              # Save s2 (last element value)

    mv   s0, a0                 # Save array pointer in s0
    mv   s1, a1                 # Save array size n in s1

    # --- Base Case: if (n == 1) return arr[0] ---
    li   t0, 1
    bne  s1, t0, RecursiveStep  # If n != 1, jump to recursive step
    lw   a0, 0(s0)              # Return value = arr[0]
    j    Done                   # Jump to cleanup

RecursiveStep:
    # Load last element: arr[n - 1]
    addi t1, s1, -1             # t1 = n - 1
    slli t1, t1, 2              # Offset = (n - 1) * 4
    add  t1, s0, t1             # Address of arr[n - 1]
    lw   s2, 0(t1)              # s2 = arr[n - 1]

    # --- Recursive Call: find_array_max_rec(arr, n - 1) ---
    mv   a0, s0                 # Pass array base pointer
    addi a1, s1, -1             # Pass n - 1 as size
    jal  ra, find_array_max_rec # Returns max of first (n - 1) elements in a0

    # --- Nested Call: get_larger(max_of_rest, arr[n - 1]) ---
    mv   a1, s2                 # Argument 2: arr[n - 1]
    jal  ra, get_larger         # Returns larger of the two in a0

Done:
    # Stack frame restore & cleanup
    lw   s2, 0(sp)              # Restore s2
    lw   s1, 4(sp)              # Restore s1
    lw   s0, 8(sp)              # Restore s0
    lw   ra, 12(sp)             # Restore return address
    addi sp, sp, 16             # Deallocate stack frame
    ret                         # Return to caller

get_larger:
    bge  a0, a1, ReturnX        # If x >= y, return x (already in a0)
    mv   a0, a1                 # Else, set return value to y

ReturnX:
    ret                         # Return to caller