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
;  File purpose: An assembly file that sorts the pointers in an array based on the contents
;  Language: Assembly
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 sortpointers.asm -o sortpointers.o 

global sortpointers

segment .data ; Where you declare constant variables that will be used throughout your code

segment .bss ; Where you initialize memory that can be changed and used throughout your code 
    ; These will be used for xsave
    align 64
    save resb 832

segment .text ; Where you actually write x86 code

sortpointers:
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

    ; We are implementing a modified bubble sort here
    ; Here are the steps we are using:
    ; 1. Iterate through our array
    ; 2. If the current element is smaller than the last one, swap the two
    ; 3. Keep track of how many times we swap while iterating
    ; 4. If we iterate the whole list without swapping once, the list is sorted
    
    mov r8, rdi ; r8 will hold the address of our array
    mov r9, rsi ; r9 will hold the size of the array
    xor r10, r10 ; r10 will hold our loop counter
    inc r10 ; + 1 because we are comparing backwards in this sorting algo
    xor r11, r11 ; r11 will count the comparison we've made without swapping
    xor r12, r12 ; This will be a temp variable used later
    xor r13, r13 ; This will be a temp variable used later

    jmp sweep

restart:
    xor r10, r10
    inc r10
    xor r11, r11
    inc r11
    jmp sweep

sweep:
    ; If this condition is true, we are done sorting the whole array
    cmp r11, r9
    je done
    ; If this condition is true, start a new sweep
    cmp r10, r9
    jge restart

    ; If our current element is smaller than the last, we should swap the two
    ; Start by putting them in temp registers
    mov r12, [r8 + r10 * 8 - 8]
    mov r13, [r8 + r10 * 8]
    ; Now extract their values
    movsd xmm8, [r12]
    movsd xmm9, [r13]
    ; Now compare the two, swap if necessary
    ucomisd xmm8, xmm9
    ja swap

    ; Increment clean sweep counter if no swap was called
    inc r11
    jmp after_swap

swap:
    ; Swap the two pointers using the registers we used earlier
    mov r12, [r8 + r10 * 8 - 8]
    mov r13, [r8 + r10 * 8]
    mov [r8 + r10 * 8 - 8], r13
    mov [r8 + r10 * 8], r12
    ; Continue with our operations
    jmp after_swap

after_swap:
    ; Increment our loop counter and continue looping
    inc r10
    jmp sweep

done:

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