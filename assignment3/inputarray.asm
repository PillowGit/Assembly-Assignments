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
;  Date of last update: ??????????
;  Date comments upgraded: ??????????????
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


global inputarray

segment .data ; Where you declare constant variables that will be used throughout your code

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


    ;==================================== code here






    ;==================================== code here


    ; Restore the backed up component
    mov rax, 7
    mov rdx, 0
    xrstor [save]

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