
; Esteban Escartin
; Assembly 240-03
; eescartin@csu.fullerton.edu
; 12/6/2023

extern printf
extern scanf
extern rdrand
time equ 17250000000000

global output_array

segment .data
    format db "0x%016lx = %-18.13g", 10, 0
    delay_msg db "What is the delay time you prefer (seconds)? ", 0
    freq_msg db "What is the maximum frequency of your cpu (GHz)? ", 0
    float_format db "%lf", 0

segment .bss
    align 64
    store resb 832

segment .text
output_array:

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
    xor r12, r12
    xor r11, r11

    push qword 0

loop:
    ; exit if at last index
    cmp r13, r15
    jge finished

    ; Print out the current number
    push qword 0
    mov rax, 1
    mov rdi, format
    mov rsi, [r14 + r13 * 8]
    movsd xmm0, [r14 + r13 * 8]
    call printf
    pop rax

    ; Delay a certain amount
    xor r12, r12
delay:
    inc r12
    cmp r12, time
    jge delay

    ; loop
    inc r13
    jmp loop

finished:

    pop rax

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