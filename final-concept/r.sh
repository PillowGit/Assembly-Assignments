#!/bin/bash

# Compile each and every assembly file
nasm -f elf64 main.asm -o main

./main

# Clean up object files after the program runs
rm main