
// Code by Esteban Escartin

#include <iostream>
#include <stdio.h>
#include <cstring>

extern "C" double compute_trip();

int main()
{
    // Print the initial welcome message
    std::cout << "Welcome to Trip Advisor by Esteban Escartin.\nWe help you plan your trip.\n";
    // Call the assembly function
    double res = compute_trip();
    // Print the ending message, including the result of the assembly function
    std::cout << "The main module received this number " << res << " and will keep it for a while.\nA zero will be sent to your operating system.\nGood-bye. Have a great trip." << std::endl;
    // Exit with code 0
    return 0;
}