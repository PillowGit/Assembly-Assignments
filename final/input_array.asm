
; Esteban Escartin
; Assembly 240-03
; eescartin@csu.fullerton.edu
; 12/6/2023

extern printf
extern rdrand

global input_array

segment .data
    filled db "The array has been filled with random numbers", 10, 0
segment .bss
    align 64
    store resb 832

segment .text
input_array:

    ; Back up the general purpose registers
    push rbp                                          ;Backup rbp
    mov  rbp,rsp                                      ;The base pointer now points to top of stack
    push rdi                                          ;Backup rdi
    push rsi                                          ;Backup rsi
    push rdx                                          ;Backup rdx
    push rcx                                          ;Backup rcx
    push r8                                           ;Backup r8
    push r9                                           ;Backup r9
    push r10                                          ;Backup r10
    push r11                                          ;Backup r11
    push r12                                          ;Backup r12
    push r13                                          ;Backup r13
    push r14                                          ;Backup r14
    push r15                                          ;Backup r15
    push rbx                                          ;Backup rbx
    pushf

    ; xsave backup
    mov rax, 7
    mov rdx, 0
    xsave [store]

    ; r13 is for the index
    ; rdi contains the address of the array to fill
    ; rsi contains the length of the array 
    xor r13, r13
    mov r14, rdi
    mov r15, rsi

loop:
    ; exit if at last index
    cmp r13, r15
    jge finished

    ; random number goes into r12
    rdrand r12

    ; push number into array
    mov [r14 + r13 * 8], r12

    ; loop
    inc r13
    jmp loop

finished:

    ; Print that the array is filled
    mov rax, 0
    mov rdi, filled
    call printf

    ; restore xsave
    mov rax, 7
    mov rdx, 0
    xrstor [store]

    ; Restore our registers
    popf                                    ;Restore rflags
    pop rbx                                 ;Restore rbx
    pop r15                                 ;Restore r15
    pop r14                                 ;Restore r14
    pop r13                                 ;Restore r13
    pop r12                                 ;Restore r12
    pop r11                                 ;Restore r11
    pop r10                                 ;Restore r10
    pop r9                                  ;Restore r9
    pop r8                                  ;Restore r8
    pop rcx                                 ;Restore rcx
    pop rdx                                 ;Restore rdx
    pop rsi                                 ;Restore rsi
    pop rdi                                 ;Restore rdi
    pop rbp                                 ;Restore rbp

    ret