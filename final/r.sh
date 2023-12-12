#!/bin/bash

# Compile each and every assembly file
nasm -f elf64 manage.asm -o manage.o
nasm -f elf64 input_array.asm -o input_array.o
nasm -f elf64 output_array.asm -o output_array.o

# Compile the C file
gcc -c main.c -o main.o

# Create the executable and run the file
g++ -m64 -o src.o main.o manage.o input_array.o output_array.o -fno-pie -no-pie -std=c++17

./src.o

# Clean up object files after the program runs
rm *.o