; Name: David Solano
; CWID: 886596832
; Program: Inputs the values to the array

global input_array
extern scanf

segment .data
floatform db "%lf", 0

segment .text
input_array:
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
    ; Inputting the information from the parameters into the registers
    mov r14, rdi
    mov r15, rsi
    xor r13, r13
loop:
    ; Ensuring that the capacity isn't surpassed by the counter variable
    cmp r13, r15

    je done
    mov rax, 0
    mov rdi, floatform ; Specify's that a float will be inputted
    push qword 0
    mov rsi, rsp
    call scanf ; Call for the input value
    cdqe ; sign-extends DWORD (32-bit value) in the EAX register to a QWORD (64-bit value) in the RAX register
    cmp rax, -1
    pop r12 ; Pop the value into r12
    je done
    mov [r14 + r13 * 8], r12 ; Place the value at the valid memory address
    inc r13 ; Counter increments
    jmp loop ; Loop repeats
done:
    pop rax
    mov rax, r13
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

    ret                                     ;Pop the integer stack and jump to the address equal to the popped value.
