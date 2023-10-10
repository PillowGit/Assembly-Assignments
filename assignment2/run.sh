#!/bin/bash

# Bash Script written by Esteban Escartin
# CWID: 886178409

# Compile the assembly files
nasm -f elf64 input_array.asm -o input_array.o
nasm -f elf64 sum_array.asm -o sum_array.o
nasm -f elf64 output_array.asm -o output_array.o
nasm -f elf64 manage.asm -o manage.o

# Compile the C file without -fPIE
gcc -c main.c -o main.o

# Link all object files together with -no-pie
gcc -no-pie main.o input_array.o sum_array.o output_array.o manage.o -o my_program

# Run the program
./my_program

# Clean up the object files and executable
rm *.o my_program
