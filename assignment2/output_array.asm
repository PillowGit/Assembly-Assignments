
; File written by Esteban Escartin
; CWID: 886178409

section .data
    float_format db "%f", 10, 0

section .text
    extern printf
    global output_array

output_array:

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

    ; Store the parameters (array and array_size)
    mov r15, rsi ; Times to loop
    xor r13, r13 ; Loop counter
    mov r14, rdi ; Array Pointer

loop3:
    ; Check if we finished looping through array
    cmp r13, r15
    je done

    ; Print a single float from the array
    push qword 0
    mov rax, 1
    movq xmm0, [r14 + r13 * 8]
    mov rdi, float_format
    call printf
    pop rax

    ; Increment the loop and restart
    inc r13
    jmp loop3

done:
    mov rax, 0
    pop rax

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

    ; Return with nothing special in rax
    ret
