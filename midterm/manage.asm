global manage
extern input_array
extern outputarray
extern rot_left
extern sum_array
extern printf

max_array_size equ 10

segment .data
    intro_msg db "Please enter floating point numbers separated by ws. After the last valid input enter one more ws followed by control+d", 10, 0
    array_print_prompt db "This is the array: ", 0
    first_rotate db "Function rot-left was called 1 time.", 10, 0
    second_rotate db "Function rot_left was called 3 times consecutively.", 10, 0
    third_rotate db "Function rot_left was called 2 times consecutively.", 10, 0

    ; formats to be used when printing
    string_form db "%s", 0
    float_form db "%lf", 0

segment .bss 
    align 64
    save resb 832
    align 16
    array resq max_array_size

segment .text

manage:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ; Utilize xsave to backup component
    mov rax, 7
    mov rdx, 0
    xsave [save]

    ; Print intro message
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, intro_msg
    call printf

    ; Start array input
    mov rax, 0
    mov rdi, array
    mov rsi, max_array_size
    call input_array
    mov r13, rax ; r13 is actual array size
    ;pop rax

    ; Print the array once
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, array_print_prompt
    call printf

    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call outputarray 

    ; Call rotate once
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left

    ; Let them know we rotated
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, first_rotate
    call printf

    ; Print the array again
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, array_print_prompt
    call printf
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call outputarray 

    ; Call rotate 3 times
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left

    ; Let them know we rotated
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, second_rotate
    call printf

    ; Print the array again
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, array_print_prompt
    call printf
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call outputarray 

    ; Call rotate 2 times 
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call rot_left

    ; Let them know we rotated
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, third_rotate
    call printf

    ; Print the array again
    mov qword rax, 0
    mov rdi, string_form
    mov rsi, array_print_prompt
    call printf
    mov rax, 0
    mov rdi, array
    mov rsi, r13
    call outputarray 

    ; Call array sum - sum goes into xmm0
    mov rax, 0
    mov rsi, r13
    mov rdi, array
    call sum_array
    movq xmm0, [r12]

    ; Restore the backed up component
    mov rax, 7
    mov rdx, 0
    xrstor [save]

    movsd xmm0, [r12]

    ; Restore the general purpose registers
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp



    ret