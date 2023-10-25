#include <stdio.h>

extern "C" void outputarray(double[], unsigned long);

void outputarray(double arr[], unsigned long arr_size)
{
    for (unsigned long idx = 0; idx < arr_size; ++idx)
    {
        printf("%1.10lf ", arr[idx]);
    }
    printf("\n");
}