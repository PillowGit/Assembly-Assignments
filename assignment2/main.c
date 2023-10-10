#include <stdio.h>

// File created by Esteban Escartin
// CWID: 886178409

extern double manage();

int main()
{
    double result = 0.0;
    printf("Welcome to the Array Management System\nThis product is maintained by Esteban Escartin at eescartin@csu.fullerton.edu\n");
    result = manage();
    printf("The main function received %f and will keep it for a while.\nPlease consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system.  Bye\n", result);

    return 0;
}
