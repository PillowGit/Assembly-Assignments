
; Created by Esteban Escartin

section .data
    msg1 db "We will take care of all your array needs.", 10, 0
    msg2 db "Please input float numbers separated", 0
    msg3 db " by whitespace.", 10, 0
    msg4 db "After the last number, press whitespace ", 0
    msg5 db "followed by Ctrl-D", 10, 0
    msg6 db "Thank you. The numbers in the array are:", 10, 0
    msg7 db "The sum of numbers in the array is: %f", 10, 0
    msg8 db "Thank you for using Array Management System.", 10, 0

    int_format db "%d", 10, 0
    float_format db "%f"
    array_size equ 8

section .bss
    align 16
    array resq array_size  ; Reserve space for an array of 8 floats

section .text
global manage

extern array_input
extern array_sum
extern array_output
extern printf

manage:

    ; Backing up registers
    push rbp                                         
    mov  rbp,rsp                                     
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

    ; Output the introductory strings
    push rbp
    mov rdi, msg1
    call printf
    pop rbp

    push rbp
    mov rdi, msg2
    call printf
    pop rbp

    push rbp
    mov rdi, msg3
    call printf
    pop rbp

    push rbp
    mov rdi, msg4
    call printf
    pop rbp

    push rbp
    mov rdi, msg5
    call printf
    pop rbp

    ; Call on the input_array function to get the users input
    ; We still store the final array_size in r13 after input
    push qword 0
    mov rax, 0
    mov rdi, array ; Push the address of the array into rdi
    mov rsi, 8 ; Push our array's size (8) into rsi for use in the function
    call array_input
    mov r13, rax ; Retrieve the # of floats the user gave us
    pop rax

    ; Print the next prompt before calling print array
    push rbp
    mov rdi, msg6
    call printf
    pop rbp

    ; Call print array, pass in the array and array length
    push qword 0
    mov rax, 0
    mov rdi, array ; Pointer to our array again :*
    mov rsi, r13 ; This is the number of array elements to print
    call array_output
    pop rax

    ; Call sum array, pass in parameters again
    push qword 0 
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call array_sum
    movsd xmm15, xmm0 ; xmm0 held our final sum, we are moving it to xmm15
    pop rax

    ; Store the result of array_sum and print it
    push rbp
    movsd xmm0, xmm15 
    mov rdi, msg7
    call printf
    pop rbp

    ; Print the final message
    push rbp
    mov rdi, msg8
    call printf
    pop rbp

    ; Restoring registers, return the sum if doing without challenge, or return array pointer otherwise
    pop rax
    mov rax, [array_sum]
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

    ret