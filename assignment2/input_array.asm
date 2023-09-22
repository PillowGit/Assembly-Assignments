
; File created by Esteban Escartin
start_ind equ 0

section .data
    eight_byte_format db "%lf", 0
    count_message db "You have entered %1ld floating point numbers.", 10, 0

section .text

extern printf
extern scanf
global array_input

array_input:

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


    ; Grab the array (which was in rdi) and the max loop count (8)
    mov r14, rdi ; Holds the array address
    mov r15, rsi ; Holds the max loop count
    xor r13, r13 ; Holds our loop count

loop1:
    ; Check the loop counter
    cmp r13, r15
    je finish

    ; Read a single float from input
    mov rax, 0
    mov rdi, eight_byte_format
    push qword 0
    mov rsi, rsp
    call scanf

    ; Check if input was ctrl-d
    cdqe
    cmp rax, -1
    pop r12 ; Push num we analyzed into r12 to store later
    je finish
    
    ; If not, push our value into it's place on the array
    mov [r14 + 8 * r13], r12
    inc r13
    jmp loop1

finish:
    ; Push r13 into rax for use in manage.asm, after this function is done
    pop rax
    mov rax, r13

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

    ; Return with the # of elements stored in rax
    ret

    ret