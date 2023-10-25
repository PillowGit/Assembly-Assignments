global sum_array

section .data

section .bss
    align 64
    Save resb 832

section .text
    sum_array:
        push       rbp
        mov        rbp, rsp
        push       rbx 
        push       rcx
        push       rdx 
        push       rsi 
        push       rdi 
        push       r8 
        push       r9  
        push       r10 
        push       r11
        push       r12 
        push       r13  
        push       r14   
        push       r15
        pushf
        pushf

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        xor r13, r13                       
        mov r14, rdi                        
        mov r15, rsi

        xorpd xmm0, xmm0 

    array_loop_start:
        cmp r13, r15 
        je array_loop_end

        movsd xmm1, qword [r14 + r13 * 8]
        addsd xmm0, xmm1
        inc r13 
        jmp array_loop_start

    array_loop_end:
        movsd qword [r12], xmm0 
        movq r12, xmm0
        
        mov rax, 7
        mov rdx, 0
        xrstor [Save]
        
        popf 
        popf
        pop        r15
        pop        r14
        pop        r13
        pop        r12
        pop        r11
        pop        r10
        pop        r9
        pop        r8
        pop        rdi
        pop        rsi
        pop        rdx
        pop        rcx
        pop        rbx
        pop        rbp

        ret