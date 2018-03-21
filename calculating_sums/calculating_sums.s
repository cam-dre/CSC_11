.section .data
/* number to be read in by user */
number: .word 0

/* Prompt */
prompt: .asciz "Enter a positive integer value (can't be less than 1): "

/* Responses */
sum_response: .asciz "The sum of all the integers from one up to %d is %d\n"
power_response: .asciz "The sum of all the powers from one up to %d is %d\n\n"

/* Format pattern for scanf */
pattern: .asciz "%d"

.section .text
.global main 
main:
	push {lr}		// link register pushed on to stack
	ldr r0, =prompt		// r0 assigned pointer to prompt message
	bl printf		// prompt message is output to user

	ldr r0, =pattern	// r0 assigned pointer to scanf pattern
	ldr r1, =number		// r1 assigned pointer to variable number
	bl scanf		// scanf used to read in number form user

	mov r0, #1		// r0 contains counter for while loop
	mov r2, #0		// r2 r3 and r4 are initialized with a value of zero
	mov r3, #0
	mov r4, #0		

while_r0_le_r1:
	ldr r1, =number
	ldr r1, [r1]		// value in register r1 is dereferenced
	cmp r0, r1 		// compare r0 to r1
	bgt end_while		// if r0 > r1 break out of while loop
	add r2, r2, r0		// r2+=r0; running total is accumulated while r0 is less than r1
	mul r3, r0, r0		// the value in register r0 is squared and stored in register r3
	add r4, r4, r3		// r4+=r3; running total of squared numbers is accumulated
	add r0, #1		// increase the counter by one
	bal while_r0_le_r1	// branch back to top of while loop

end_while:
	ldr r0, =sum_response	// r0 assigned pointer to sum_response
	ldr r1, =number		// r1 assigned pointer to variable number
	ldr r1, [r1]		// r1 value is dereferenced
	mov r2, r2		// sum of all the integers accumulated from while loop above is moved into r2
	bl printf		// sum_response is output to screen
	
	ldr r0, =power_response	// r0 assigned pointer to power_response
	ldr r1, =number		
	ldr r1, [r1]
	mov r2, r4		// sum of all the squared integers accumulated from while loop above is moved into r2 
	bl printf		// power_response is output to screen

	mov r0, #0		// program is exited normally
	pop {pc}
