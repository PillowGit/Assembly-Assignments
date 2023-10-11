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
//  Date of last update: ??????????
//  Date comments upgraded: ??????????????
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
//  File name: outputarray.cpp
//  File purpose: A C++ file containing a function to output an array of pointers 
//  Language: C++
//  Max page width: 132 columns
//  Assemble: g++ -c -m64 -Wall -o outputarray.o outputarray.cpp -fno-pie -no-pie -std=c++17

#include <stdio.h>

extern "C" void outputarray(double* [], unsigned long);

void outputarray(double *arr[], unsigned long arr_size)
{
    for (unsigned long idx = 0; idx < arr_size; ++idx)
    {
        printf("%1.10lf\n", *(arr[idx]));
    }
}