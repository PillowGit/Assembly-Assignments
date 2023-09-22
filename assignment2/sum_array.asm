
; File created by Esteban Escartin

section .text
global array_sum

array_sum:

    ; Backup registers once again
    push rbp
    mov rbp,rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf
    push qword 0

    ; Store the parameters we are given
    mov r14, rdi ; Array Pointer
    mov r15, rsi ; Max Loop Count
    xor r13, r13 ; Loop Counter

    ; Prep the xmm register
    mov rax, 1
    mov rdx, 0
    cvtsi2sd xmm15, rdx

loop2:
    ; Check if we are done moving through array
    cmp r13, r15
    je complete

    ; Add the float to our register of choice
    addsd xmm15, [r14 + 8 * r13]

    ; Incremenet and loop
    inc r13
    jmp loop2

complete:

    pop rax
    movsd xmm0, xmm15 ; Moving our sum into xmm0 to be returned

    ; Restore the registers
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp

    ret