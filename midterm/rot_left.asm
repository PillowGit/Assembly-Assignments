global rot_left

segment .bss
    align 64
    Save resb 832

segment .text
rot_left:
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
    ; xsave
    mov rax, 7
    mov rdx, 0
    xsave [Save]
    ; Function parameters
    mov r14, rdi
    mov r13, rsi
    ; Store start of array for rotate steps
    movsd xmm0, [r14]
    ; Loop counter
    xor r15, r15
    inc r15

begin_loop:
    ; check loop counter
    cmp r15, r13
    je end_loop
    ; shift elements to mimic rotating
    movsd xmm15, [r14 + r15 * 8]
    movsd [r14 + (r15 - 1) * 8], xmm15
    ; loop
    inc r15
    jmp begin_loop

end_loop:
    ; set back to what was originally front for the element that wraps around left
    movsd [r14 + (r13 - 1) * 8], xmm0
    ; xsave
    mov rax, 7
    mov rdx, 0
    xrstor [Save]

    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret