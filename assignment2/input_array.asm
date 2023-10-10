
; File written by Esteban Escartin
; CWID: 886178409

global input_array
extern scanf

segment .data
floatform db "%lf", 0

segment .text
input_array:
    ; Save our registers
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

    ; Store all the information that was given when function was called
    mov r14, rdi ; Array Pointer
    mov r15, rsi ; Elements used in our array
    xor r13, r13 ; A counter for our loop

loop:

    ; Check the loop count, exit if necessary
    cmp r13, r15
    je done

    ; Take in a users input
    mov rax, 0
    mov rdi, floatform
    push qword 0
    mov rsi, rsp
    call scanf ; Call for the input value

    cdqe ; Pushed input into RAX, or at least i THINK 

    ; Check for ctrl + D
    cmp rax, -1
    pop r12 ; Pop the value we analyzed into r12 
    je done

    ; Insert the value into the array, increment our loop, and redo the whole thing
    mov [r14 + r13 * 8], r12 
    inc r13
    jmp loop

done:
    ; Return the number of elements that we analyzed, r13 in this case since that was our loop counter
    pop rax
    mov rax, r13

    ; Restore general purpose registers
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

    ; Return with our array size in r13
    ; Note that we aren't returning the array because we modified the data at the pointer
    ret
