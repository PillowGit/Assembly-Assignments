
; Esteban Escartin
; Assembly 240-03
; eescartin@csu.fullerton.edu
; 12/6/2023

extern printf
extern input_array
extern output_array

array_size equ 8

global manage

segment .data
    msg1 db "We will take care of all your array needs", 10, 0
    msg2 db "Please input float numbers separated by ws. After the last number press ws followed by control-d", 10, 0
    msg3 db "Here are the values in the array", 10, 0
    msg4 db "The numbers of the array have been displayed.", 10, 0
    msg5 db "Thank you for using Array Management System.",10 , 0
segment .bss
    array resq array_size
    align 64
    store resb 832

segment .text

manage:

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

    ; perform xsave
    mov rax, 7
    mov rdx, 0
    xsave [store]

    ; Display the intro message to the user
    mov rax, 0
    mov rdi, msg1
    call printf

    ; Prompt the user for floats
    mov rax, 0
    mov rdi, msg2
    call printf

    ; Call input array
    mov rax, 0
    mov rdi, array
    mov rsi, array_size
    call input_array

    ; Tell the user we are printing their array
    mov rax, 0
    mov rdi, msg3
    call printf

    ; Call output array
    mov rax, 0
    mov rdi, array
    mov rsi, array_size
    call output_array

    ; Print last two messages 
    mov rax, 0
    mov rdi, msg4
    call printf
    mov rax, 0
    mov rdi, msg5
    call printf

    ; restore xsave
    mov rax, 7
    mov rdx, 0
    xrstor [store] 

    ; Return the array size to main
    mov rax, array_size

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