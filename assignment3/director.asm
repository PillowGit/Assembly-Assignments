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
;  File purpose: An assembly file driving the program and calling other files such as output array, input array, and sort pointers 
;  Language: Assembly
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 director.asm -o director.o 



; Include our external functions
extern printf
extern inputarray
extern outputarray
extern sortpointers 

; Declare the function defined in this file
global director

; Save enough space for 8 pointers in an array
array_len equ 8

segment .data ; Where you declare constant variables that will be used throughout your code
    ; Declare all of the strings we will use for print statements
    intro_msg db "This program will sort all of your doubles", 10, 0
    input_prompt db "Please enter floating point numbers separated by white space. After the last numeric input enter at leas t one more white space and press ctrl + d", 10, 0
    after_input db "Thank you. You entered these numbers:", 10, 0
    after_output db "End of output of array", 10, 0
    sort_prompt db "The array is now being sorted without moving any numbers", 10, 0
    show_again db "The data in the array is now ordered as follows:", 10, 0
    ; do after_output again
    final_msg db "The array will be sent back to the caller function", 10, 0

    ; formats to be used when printing
    string_form db "%s", 0
    float_form db "%lf", 0

segment .bss ; Where you initialize memory that can be changed and used throughout your code
    ; These will be used for xsave
    align 64
    save resb 832
    ; This will be our array of pointers
    array resq array_len

segment .text ; Where you actually write x86 code

director:
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


    ; Print all of the introductory prompts
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, intro_msg
    call printf

    mov qword rax, 0
    mov rdi, input_prompt
    mov rsi, intro_msg
    call printf

    ; Now take in the user input
    mov rax, 0
    mov rdi, array ; Putting the pointer to the array in rdi
    mov rsi, array_len ; Max length of array_len will be in rsi
    call inputarray
    mov r13, rax ; Actual array length will be stored in r13

    ; Conclude the dialogue on user inputs
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, after_input 
    call printf

    ; Call on an external function to print out the array for us
    mov rax, 0
    mov rdi, array ; The array pointer will again be in rdi
    mov rsi, r13 ; This time, rsi will hold the number of elements in the array to print
    call outputarray

    ; Print the end of output message
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, after_output
    call printf

    ; Tell the user we will start sorting 
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, sort_prompt
    call printf

    ; Call on sort pointers to do its thing
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call sortpointers

    ; Show the user that we sorted the array
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, show_again
    call printf

    ; Print out the array once again
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call outputarray

    ; End of printing array
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, after_output
    call printf

    ; Display the final message
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, final_msg
    call printf

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

    ; Set the array to be returned
    mov rax, array

    ret