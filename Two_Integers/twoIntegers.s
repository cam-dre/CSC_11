// ===================================================================================================================
// Assignment - Two Integers
// ===================================================================================================================
// Programmer: Cameron Perry
// Class: CSC 11
// ===================================================================================================================
.section .data
/* First number read in by user */
number_1: .word 0
number_2: .word 0

/* Prompts */
intro: .asciz "Hello! Welcome to Two Integers.\n\n"
prompt: .asciz "Please enter two integers (seperated by a space): "

/* Responses */
sum_response: .asciz "The sum of %d and %d is %d\n\n"
diff_response: .asciz "The difference of %d and %d is %d\n\n"
prod_response: .asciz "The product of %d and %d is %d\n\n"

/* Format patternfor scanf */
pattern: .asciz "%d %d"

.section .text
.global main
main:
	push {lr}			// link register pushed on to stack
	ldr r0, =intro			// r0 assigned pointer to intro message
	bl printf			// intro message is output with printf

	ldr r0, =prompt			// r0 assigned pointer to prompt message
	bl printf			// printf used to output prompt message

	ldr r0, =pattern		// r0 contains pointer to format string for scan pattern
	ldr r1, =number_1		// r1 contains pointer to variable label where number_1 is stored
	ldr r2, =number_2		// r2 contains pointer to variable label where number_2 is stored
	bl scanf			// scanf used to read in numbers from user

	ldr r0, =sum_response		// r0 assigned pointer to sum_response message
        ldr r1, =number_1
        ldr r1,[r1]			// value in r1 is dereferenced and assigned to register r1
        ldr r2, =number_2		
	ldr r2, [r2]			// value in r2 is dereferenced and assigned to register r2
	add r3, r1, r2			// values in r1 and r2 are added and assigned to r3
	bl printf			// printf used to output sum_response and values in all 3 registers
	
	
	ldr r0, =diff_response		// r0 assigned pointer to diff_response message
        ldr r1, =number_1
        ldr r1,[r1]
        ldr r2, =number_2
	ldr r2, [r2]
	sub r3, r1, r2			// values in r1 and r2 are subtracted and assigned to r3
	bl printf			// printf used to output diff_response and values in all 3 registers
	
	
	ldr r0, =prod_response		// r0 assigned pointer to prod_response message
        ldr r1, =number_1
        ldr r1,[r1]
        ldr r2, =number_2
	ldr r2, [r2]
	mul r3, r1, r2			// values in r1 and r2 are multiplied and assigned to r3
	bl printf			// r0 assigned pointer to prod_response message



	mov r0, #0			// exit code 0 program terminated normally
	pop {pc}			// function is exited
