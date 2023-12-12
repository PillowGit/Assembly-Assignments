global _start
extern printf 

segment .data
    output db "The division resulted in a remainder equal to %d", 10, 0
    numerator dd 3585193
    denominator dd 17629

segment .text
_start:
    mov r14, [numerator]
    mov r13, [denominator]
find_r: 
    sub r14, r13
    cmp r14, 0
    jge find_r

    add r14, r13

    mov rax, 1
    mov rdi, output
    mov rsi, r14
    call printf

    ret

    