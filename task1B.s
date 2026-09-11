# .text
# .globl main
# main:

# # #include <iostream>
# # using namespace std;
# # int main(){

# #     int factorial = 1;
# #     for (int i=5; i>0; i--)
# #     {
# #         factorial *= i;
# #     }
# #     cout << "Factorial of 5 is: " << factorial << endl;
# # }

# li x5, 1 # factorial = 1
# li x6, 5 # i = 5

# loop:
#     beq x6, x0, end # if i == 0, exit loop
#     mul x5, x5, x6 # factorial *= i
#     addi x6, x6, -1 # i--
#     j loop

# end:
#     j end

.text
.globl main
main:

addi x5, x0, 1 # acc = 1
addi x6, x0, 5 # n=5
jal x1, While # call While function
ecall
j end

While:
    ble x6, x0, done # if n <= 0, exit loop
    mul x5, x5, x6 # acc *= n
    addi x6, x6, -1 # n--
    j While # repeat loop

done:
    addi x10, x0, 1 
    addi x11, x5, 0 # move result to a1 for return
    ret

end:
    j end