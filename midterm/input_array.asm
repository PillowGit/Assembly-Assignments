global input_array
extern scanf

segment .bss
    align 64
    savedata resb 832

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
    mov rax, 7
    mov rdx, 0
    xsave [savedata]

    ; Function parameters
    mov r14, rdi
    mov r15, rsi
    xor r13, r13

loop:
    ; Loop count check
    cmp r13, r15
    je done
    ; Take user input
    mov rax, 0
    mov rdi, floatform
    push qword 0
    mov rsi, rsp
    call scanf
    cdqe
    ; Check for ctrl d
    cmp rax, -1
    pop r12
    je done
    ; Place the float
    mov [r14 + r13 * 8], r12
    ; Loop part
    inc r13
    jmp loop
done:
    ; xsave
    mov rax, 7
    mov rdx, 0
    xrstor [savedata]
    pop rax
    ; set array size to return
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
