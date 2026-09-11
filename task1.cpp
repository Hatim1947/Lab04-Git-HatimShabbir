#include <iostream>
using namespace std;
int main(){

    int factorial = 1;
    for (int i=5; i>0; i--)
    {
        factorial *= i;
    }
    cout << "Factorial of 5 is: " << factorial << endl;
}