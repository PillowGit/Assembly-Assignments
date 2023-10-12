;*
;*Program name: "Pointer Sorting".                                                                                           *
;*Copyright (C) 2023 Esteban Escartin.                                                                                       *
;*                                                                                                                           *
;*This file is part of the software program "Pointer Sorting".                                                               *
;*Pointer Sorting is free software: you can redistribute it and/or modify it under the terms of the GNU General Public       *
;*License version 3 as published by the Free Software Foundation.                                                            *
;*Pointer Sorting is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the              *
;*implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;*details.  A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                 *

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Author information
;  Author name: Esteban Escartin
;  Author email: eescartin@csu.fullerton.edu
;  Author CWID: 886178409 
;  Author NASM: NASM version 2.15.05 

;Program information
;  Program name: Pointer Sorting
;  Programming languages: Two modules in C++ and three modules in X86
;  Date program began: Oct-5-23
;  Date of last update: Oct-12-23
;  Date comments upgraded: Oct-12-23
;  Date open source license added: Oct-5-2023
;Files in this program: director.asm, input_array.asm, main.cpp, output_array.cpp, sort_pointers.asm
;  Status: Finished.

;Purpose
;  The purpose of this program is to create a pointer array in which the user inputs up to 8 values and the program creates 
;  an array of pointers that point to those values. The program also prints the values that the user inputted, and it is
;  also responsible for sorting the array and correctly printing the sorted pointed array from least to greatest. This is
;  done to showcase sorting by pointers. This is a techniques used so that you can sort an array without having to move much
;  memory around (besides the pointers) just incase the memory is very large.

;This file
;  File name: director.asm
;  File purpose: An assembly file that takes user input and creates an array of max size 8 containing pointers to doubles 
;  Language: Assembly
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 inputarray.asm -o inputarray.o

extern malloc
extern scanf
global inputarray

segment .data ; Where you declare constant variables that will be used throughout your code
    ; The float format we will be looking for
    float_form db "%lf", 0

segment .bss ; Where you initialize memory that can be changed and used throughout your code 
    ; These will be used for xsave
    align 64
    save resb 832

segment .text ; Where you actually write x86 code

inputarray:
    ; Back up every general purpose register
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ; Utilize xsave to backup component
    mov rax, 7
    mov rdx, 0
    xsave [save]


    ; Initialize our registers to the necessary data
    mov r14, rdi ; The pointer to our array
    mov r15, rsi ; The max size of our array
    xor r13, r13 ; This will be the counter for our input_loop, so we make it 0
    jmp input_loop

input_loop:
    ; If we have analyzed the max size already
    cmp r13, r15
    jge done

    ; Use malloc to create a pointer for a float and store the mem location in r12
    mov rax, 0
    mov rdi, 8
    call malloc
    mov r12, rax

    ; Take a users float input, throws it into the pointer
    mov rax, 0
    mov rdi, float_form
    mov rsi, r12
    call scanf 

    ; Check if the user pressed ctrl+d
    cdqe
    cmp rax, -1
    je done

    ; Place our pointer into the array
    mov [r14 + r13 * 8], r12
    inc r13
    jmp input_loop

done:


    ; Restore the backed up component
    mov rax, 7
    mov rdx, 0
    xrstor [save]

    ; Put the number of floats we analyzed to be returned
    mov rax, r13

    ; Restore the general purpose registers
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret