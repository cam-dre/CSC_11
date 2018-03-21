.section .data
/* First number read in by user */
number_1: .word 0
number_2: .word 0
sum: .word 0
difference: .word 0
product: .word 0

/* Intro message */
intro: .asciz "Hello! Welcome to Two Integers.\n\n"

/* 1st prompt */
prompt_1: .asciz "Enter an integer for first number: "

/* 2nd prompt */
prompt_2: .asciz "Enter an integer for second number: "

/* Sum response */
sum_response: .asciz "The sum of %d and %d is %d\n\n"

/* Format patternfor scanf */
pattern: .asciz "%d"

.section .text
.align 4
.global main
main:
	push {lr}
	ldr r0, =intro
	bl printf

	ldr r0, =prompt_1
	bl printf

	ldr r0, =pattern
	ldr r1, =number_1
	bl scanf

	ldr r0, =prompt_2
	bl printf

	ldr r0, =pattern
	ldr r2, =number_2
	bl scanf
next:
	ldr r0, =sum_response
        ldr r1, =number_1
        ldr r1,[r1]
        ldr r2, =number_2
	ldr r2, [r2]
	add r3, r1, r2
	bl printf

	mov r0, #0
	pop {pc}
