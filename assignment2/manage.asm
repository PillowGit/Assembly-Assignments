
; File written by Esteban Escartin
; CWID: 886178409

extern printf
extern input_array
extern output_array
extern sum_array
extern exit

max_array_size equ 8

global manage

segment .data
    msg1 db "We will take care of all your array needs", 10, 0
    msg2 db "Please input float numbers separated", 10, 0
    msg3 db "Thank you. The numbers in the array are:", 10, 0
    msg4 db "The sum of numbers in the array is %8.10lf", 10, 0
    msg5 db "Thank you for using Array Management System.", 10, 0
segment .bss
    align 16
    array resq max_array_size

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
    push qword 0

    ; Display the intro message to the user
    push qword 0
    mov rax, 0
    mov rdi, msg1
    call printf
    pop rax

    ; Prompt the user for floats
    push qword 0
    mov rax, 0
    mov rdi, msg2
    call printf
    pop rax

    ; Call on input_array to parse the users input 
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, max_array_size
    call input_array
    mov r13, rax ; r13 contains the actual size of the array, which is important later
    pop rax

    ; Tell the user we are printing their array
    push qword 0
    mov rax, 0
    mov rdi, msg3
    call printf
    pop rax

    ; Call on output_array helper function to print the entire array
    push qword 0
    mov rax, 0
    mov rdi, array  
    mov rsi, r13 ; Again it is important to note r13 is the actual size of our array
    call output_array
    pop rax

    ; Call on the function sum_array to sum the entire array and return the result
    push qword 0
    mov rax, 0
    mov rdi, array 
    mov rsi, r13 ; Once again size is important
    call sum_array
    movsd xmm15, xmm0
    pop rax

    ; Print out the sum of the array
    push qword 0
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, msg4
    call printf
    pop rax

    ; Print out the final message
    push qword 0
    mov rax, 0
    mov rdi, msg5
    call printf
    pop rax

    ; Return the sum of the array to the main file
    movsd xmm0, xmm15
    pop rax
    

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
