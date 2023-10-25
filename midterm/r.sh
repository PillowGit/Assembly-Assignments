#!/bin/bash

# Compile each and every assembly file
nasm -f elf64 manage.asm -o manage.o
nasm -f elf64 input_array.asm -o input_array.o
nasm -f elf64 rot_left.asm -o rot_left.o
nasm -f elf64 sum_array.asm -o sum_array.o

# Compile the C++ files
g++ -c -m64 -Wall -o welcome.o welcome.cpp -fno-pie -no-pie -std=c++17
g++ -c -m64 -Wall -o output_array.o output_array.cpp -fno-pie -no-pie -std=c++17

# Create the executable and run the file
g++ -m64 -o src.o welcome.o output_array.o manage.o input_array.o rot_left.o sum_array.o -fno-pie -no-pie -std=c++17

./src.o

# Clean up object files after the program runs
rm *.o