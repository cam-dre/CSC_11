.data
prompt: .asciz "Here is  your number: %d\n\n"

.text
.global main
main:
	push {lr}
	mov r1, #2

	ldr r0, =prompt
	asl r1, r1, #3
	bl printf
	pop {pc}
