#include <stdio.h>

extern "C" double manage();

int main()
{
    double res = 0.0;
    printf("Welcome to My Array by Esteban Escartin.\n");
    res = manage();
    printf("The main received this number: %f and will study it.\n", res);
    printf("0 will be returned to the operating system.\n");
    return 0;
}