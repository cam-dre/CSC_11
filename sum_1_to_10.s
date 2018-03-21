.section .rodata
greeting: .asciz "Welcome! I am going to use a while loop to sum up all integers from 1 to 10!\n"
output: .asciz "sum of %d to %d is %d\n"

.section .text
.global main
main:
	push {lr}

	ldr r0, =greeting
	bl printf

	mov r0, #1
	mov r4, #0

while_r0_le_10:			// while (r0 less than or equal to 10)
	cmp r0, #10		// compare to r0 to #10
	bgt end_while		// greater than is the opposite of less than/eaual
	add r4, r4, r0		// r4 += r0
	add r0, #1		// increment r0 by 1, like the ++ operator in C++
	bal while_r0_le_10
end_while:	
	ldr r0, =output		// output result to screen
	mov r1, #1		// r1 contains 1 for output in first format spec
	mov r2, #10		// r2 contains sum from our while loop above
	mov r3, r4		// r4 contains sum from our while loop above
	bl printf

	mov r0, #0		// return error code zero
	pop {pc}		// end of main
