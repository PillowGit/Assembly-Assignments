//*
//*Program name: "Pointer Sorting".                                                                                           *
//*Copyright (C) 2023 Esteban Escartin.                                                                                       *
//*                                                                                                                           *
//*This file is part of the software program "Pointer Sorting".                                                               *
//*Pointer Sorting is free software: you can redistribute it and/or modify it under the terms of the GNU General Public       *
//*License version 3 as published by the Free Software Foundation.                                                            *
//*Pointer Sorting is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the              *
//*implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
//*details.  A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                 *

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

//Author information
//  Author name: Esteban Escartin
//  Author email: eescartin@csu.fullerton.edu
//  Author CWID: 886178409 
//  Author NASM: NASM version 2.15.05 

//Program information
//  Program name: Pointer Sorting
//  Programming languages: Two modules in C++ and three modules in X86
//  Date program began: Oct-5-23
//  Date of last update: Oct-12-23
//  Date comments upgraded: Oct-12-23
//  Date open source license added: Oct-5-2023
//Files in this program: director.asm, input_array.asm, main.cpp, output_array.cpp, sort_pointers.asm
//  Status: Finished.

//Purpose
//  The purpose of this program is to create a pointer array in which the user inputs up to 8 values and the program creates 
//  an array of pointers that point to those values. The program also prints the values that the user inputted, and it is
//  also responsible for sorting the array and correctly printing the sorted pointed array from least to greatest. This is
//  done to showcase sorting by pointers. This is a techniques used so that you can sort an array without having to move much
//  memory around (besides the pointers) just incase the memory is very large.

//This file
//  File name: main.cpp
//  File purpose: A C++ file initializing the program & giving final output
//  Language: C++
//  Max page width: 132 columns
//  Assemble: g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

#include <iostream>
#include <stdio.h>
#include <cstring>

extern "C" double** director();

int main()
{
    std::cout << "Welcome to a great program developed by Esteban Escartin." << std::endl;
    double** end_arr = director();
    std::cout << "The main function received this set of numbers:\n";
    for (size_t i = 0; end_arr[i] != NULL; ++i)
    {
        std::cout << *(end_arr[i]) << '\n';
    }
    std::cout << "Main will keep these and send a zero to the operating system." << std::endl;
    return 0;
}