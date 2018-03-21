.data
output: .asciz  "%d\n"

.text
.global main
main:
	push {lr}

	ldr r0, =output
	mov r1, #2	
	mov r1, r1, asl #8
	bl printf
	
	mov r0, #0
	pop {pc}
