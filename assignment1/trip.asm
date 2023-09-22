
; Code by Esteban Escartin


global compute_trip
extern scanf
extern printf
extern exit

section .bss ; "Block Starting Symbols", used for storing all your variables, most important, permanent memory locations
    ; Storage Variables
    init_speed resq 1
    init_dist resq 1
    init_time resq 1
    second_speed resq 1
    second_dist resq 1
    second_time resq 1
    total_time resq 1
    avg_speed resq 1


section .data ; Where you can initialize constants 
    ; Distance to Vegas
    dist dq 253.5
    ; Question prompts for the user
    q1 db "Please enter the speed for the initial segment of the trip (mph): ", 0
    q2 db "For how many miles will you maintain this average speed? ", 0
    q3 db "What will be your speed during the final segment of the trip (mph)? ", 0
    ; Printf formats
    string_format db "%s", 0
    decimal_format db "%lf", 0
    float_format db "%f", 10, 0
    ; Output messages
    out1 db "Your average speed will be %f mph.", 10, 0
    out2 db "The total travel time will be %f hours.", 10, 0 
    ; Exit status incase of an early quit
    exit_status dd 1
    ; Invalid input message
    invalid_inp db "Input is invalid. This program will now terminate.", 10, 0
    ; A zero used for comparisons
    zero dd 0


section .text ; Contains the logic for my code

    ;--------------------------------------------------------------------------
    ; This function is called when a user gives an invalid input.
    ; It is responsible for informing them of the error, and quitting
    ; the program entirely using exit from the C library

    quit_program: 

    ; Inform the user of the input error
    sub rsp, 8
    mov rdi, invalid_inp
    call printf
    add rsp, 8

    ; Call C's exit function to quit the program
    mov eax, dword [exit_status] 
    call exit

    ;--------------------------------------------------------------------------
    ; This is the start of the program that is called in the C++ Code, and the main program for this assignment

    compute_trip:

    ;--------------------------------------------------------------------------
    ; This whole section is for dealing with the first output and input process, including testing it

    ; Write the first question to output
    sub rsp, 8
    mov rdi, q1
    call printf
    add rsp, 8
    ; Read input from the first question and store it in xmm8
    push qword 0
    mov qword rax, 0
    mov rdi, decimal_format
    mov rsi, rsp
    call scanf
    movsd xmm8, [rsp]
    pop rax
    movsd qword [init_speed], xmm8

    ; Here we are testing the first input for invalid inputs
    ; Test if the speed is negative or == 0
    movsd xmm0, qword [init_speed]
    ucomisd xmm0, qword [zero]
    jbe quit_program

    ;--------------------------------------------------------------------------
    ; This whole section is for dealing with the second output and input process, including testing it

    ; Write the second question to output
    sub rsp, 8
    mov rdi, q2
    call printf
    add rsp, 8
    ; Read input from the second question and store it in xmm9
    push qword 0
    mov qword rax, 0
    mov rdi, decimal_format
    mov rsi, rsp
    call scanf
    movsd xmm9, [rsp]
    pop rax
    movsd qword [init_dist], xmm9

    ; Here we are testing the second input for invalid inputs
    ; Test if the distance is negative or == 0
    movsd xmm0, qword [init_dist]
    ucomisd xmm0, qword [zero]
    jbe quit_program
    ; Test if the distance is greater than or == 253.5
    movsd xmm0, qword [init_dist]
    ucomisd xmm0, qword [dist]
    jae quit_program

    ;--------------------------------------------------------------------------
    ; This whole section is for dealing with the third output and input process, including testing it

    ; Write the third question to output
    sub rsp, 8
    mov rdi, q1
    call printf
    add rsp, 8
    ; Read input from the third question and store it in xmm10
    push qword 0
    mov qword rax, 0
    mov rdi, decimal_format
    mov rsi, rsp
    call scanf
    movsd xmm10, [rsp]
    pop rax
    movsd qword [second_speed], xmm10

    ; Here we are testing the third input for invalid inputs
    ; Test if the speed is negative or == 0
    movsd xmm0, qword [second_speed]
    ucomisd xmm0, qword [zero]
    jbe quit_program

    ;--------------------------------------------------------------------------
    ; This whole section handles mathematical operations, who results will be used in the final output
    ; to the user at the end of the program

    ; Calculate the total distance of the second trip (miles)
    movsd xmm11, qword [dist]
    subsd xmm11, qword [init_dist]
    movsd qword [second_dist], xmm11

    ; Calculate the time trip 1 takes (hours)
    movsd xmm12, qword [init_dist]
    divsd xmm12, qword [init_speed]
    movsd qword [init_time], xmm12

    ; Calculate the time trip 2 takes (hours)
    movsd xmm13, qword [second_dist]
    divsd xmm13, qword [second_speed]
    movsd qword [second_time], xmm13

    ; Calculate the time for both trips (hours) 
    movsd xmm14, qword [init_time]
    addsd xmm14, qword [second_time]
    movsd qword [total_time], xmm14

    ; Calculate the average speed (mph)
    movsd xmm15, qword [dist]
    divsd xmm15, qword [total_time]
    movsd qword [avg_speed], xmm15

    ;--------------------------------------------------------------------------
    ; This program prints the final results to the user, then exits with the 
    ; total_time as the return value

    ; Print the average speed
    push qword 0
    mov rax, 1
    mov rdi, out1
    movsd xmm0, qword [avg_speed]
    call printf
    mov qword rax, 0
    pop rax

    ; Print the total travel time (hours)
    push qword 0
    mov rax, 1
    mov rdi, out2
    movsd xmm0, qword [total_time]
    call printf
    mov qword rax, 0
    pop rax
    
    ; End the program
    mov eax, total_time
    movsd xmm0, qword [total_time]
    ret