.equ LOW, 0
.equ HIGH, 1
.equ OUTPUT, 1

.data
.balign 4
intro:	.asciz "Raspberry Pi wiringPi blink test\n"
pin:	.int 7
i:	.int 0
delayMs:.int 500 

.text
.global main

main:
	push {lr}		@ push return address + dummy register
				@ for alignment
	ldr r0, =intro
	bl printf		@ printf("blink...")

	bl wiringPiSetup	@ if (wiringPiSetup() == -1) {
	ldr r0, =pin		@ pinMode(pin, OUTPUT)
	ldr r0, [r0]
	mov r1, #OUTPUT
	bl pinMode

	ldr r4, =i		@ for (i=0; <10; i++) {
	ldr r4, [r4]
	mov r5, #10

forLoop:
	cmp r4, r5
	bgt done

	ldr r0, =pin
	ldr r0, [r0]
	mov r1, #HIGH 
	bl digitalWrite

	ldr r0, =delayMs	@ delay(250)
	ldr r0, [r0]
	bl delay

	ldr r0, =pin
	ldr r0, [r0]
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =delayMs
	ldr r0, [r0]
	bl delay

	add r4, #1
	bal forLoop

done:
	pop {pc}
