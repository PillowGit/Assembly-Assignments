
; File writen by Esteban Escartin
; CWID: 886178409

global sum_array
segment .bss
segment .data
segment .text

sum_array:

    ; Backup our registers
    push rbp
    mov  rbp,rsp
    push rdi                                                    ;Backup rdi
    push rsi                                                    ;Backup rsi
    push rdx                                                    ;Backup rdx
    push rcx                                                    ;Backup rcx
    push r8                                                     ;Backup r8
    push r9                                                     ;Backup r9
    push r10                                                    ;Backup r10
    push r11                                                    ;Backup r11
    push r12                                                    ;Backup r12
    push r13                                                    ;Backup r13
    push r14                                                    ;Backup r14
    push r15                                                    ;Backup r15
    push rbx                                                    ;Backup rbx
    pushf 
    push qword 0

    ; Take note of all the information given to us in parameters
    mov r14, rdi ; Array Pointer
    mov r15, rsi ; Size of our array
    xor r13, r13 ; Loop Counter

    ; Reserve space for our one xmm register we will return
    mov rax, 1 
    mov rdx, 0

    ; Honestly idk what this does still but it's necessary for using xmm15 to store our sum
    cvtsi2sd xmm15, rdx ; xmm15 will hold our running sum

loops:
    ; Check if our loop is fnished
    cmp r13, r15 
    jge done

    ; Add the current element to xmm15 
    addsd xmm15, [r14 + 8*r13]

    ; Increment and loop!
    inc r13 
    jmp loops

done:
    ; Move our xmm15 into place to be returned
    pop rax
    movsd xmm0, xmm15

    ; Restore the registers
    popf                                                        ;Restore rflags
    pop rbx                                                     ;Restore rbx
    pop r15                                                     ;Restore r15
    pop r14                                                     ;Restore r14
    pop r13                                                     ;Restore r13
    pop r12                                                     ;Restore r12
    pop r11                                                     ;Restore r11
    pop r10                                                     ;Restore r10
    pop r9                                                      ;Restore r9
    pop r8                                                      ;Restore r8
    pop rcx                                                     ;Restore rcx
    pop rdx                                                     ;Restore rdx
    pop rsi                                                     ;Restore rsi
    pop rdi                                                     ;Restore rdi
    pop rbp                                                     ;Restore rbp

    ; Return with the array's sum in xmm0
    ret
