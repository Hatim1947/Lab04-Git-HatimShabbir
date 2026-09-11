.text
.globl main

main:
    li    x11, 5            # Load argument n = 5 into x11
    jal   x1, ntri          # Call ntri(n)

    li x10,1
    ecall
    
    j     end

ntri:
    # Check base case directly without slti:
    # If n >= 2, jump to recursive case
    li    x5, 2
    bge   x11, x5, recurse  # If x11 >= 2, branch to recurse

    # Base Case (n < 2):
    # Returns x11 as-is T(1)=1
    ret

recurse:
    addi  sp, sp, -8        # Reserve 8 bytes on stack
    sw    x1, 4(sp)         # Save return address
    sw    x11, 0(sp)        # Save current n

    # Recursive call: ntri(n - 1)
    addi  x11, x11, -1      # n = n - 1
    jal   x1, ntri          # Call ntri(n-1)

    lw    x5, 0(sp)         # Restore original n into x5
    lw    x1, 4(sp)         # Restore return address
    addi  sp, sp, 8         # Free stack frame

    # Combine step: T(n) = n + T(n-1)
    add   x11, x11, x5      # x11 = T(n-1) + n
    ret                     # Return to caller

end:
    j     end               # Infinite loop to terminate program