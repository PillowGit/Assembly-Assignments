#include <stdio.h>

// Esteban Escartin
// Assembly 240-03
// eescartin@csu.fullerton.edu
// 12/6/2023

extern int manage();

int main()
{
    int res = 0;
    printf("Welcome to Array Management System\nThis product is maintained by Esteban Escartin at eescartin@csu.fullerton.edu\n");
    res = manage();
    printf("The main function received %d and will keep it for a while.\nPlease consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system. Bye\n", res);
    return 0;
}