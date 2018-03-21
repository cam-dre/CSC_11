.equ LOW, 1
.equ HIGH, 1
.equ OUTPUT, 1

.section .data
.balign 4
number: .word 0
intro: .asciz "How long do you want the timer to be?"
display: .asciz "%d"
pattern: .asciz "%d"
delayMs: .int 1000

.section .text
.global main
main:
	push {lr}
	ldr r0, =intro
	bl printf

	ldr r0, =pattern
	ldr r1, =number
	bl scanf

	bl wiringPiSetup
	mov r0, #7
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #7
	mov r1, #HIGH
	bl digitalWrite

	bl wiringPiSetup
	mov r0, #12
	mov r1, #OUTPUT
	bl pinMode
	
	mov r0, #12
	mov r1, #HIGH
	bl digitalWrite

	ldr r4, =number
	ldr r4, [r4]
	mov r5, #0

while_number_gt_0:
	cmp r4, r5
	beq while_done
	bal print
	
delayer:
	ldr r0, =delayMs
	ldr r0, [r0]
	bl delay

	sub r4, #1
	bal while_number_gt_0

print:
	ldr r0, =display
	mov r1, r4
	bl printf
	bal delayer

while_done:
	mov r0, #7
	mov r1, #LOW
	bl digitalWrite

	mov r0, #12
	mov r1, #LOW
	bl digitalWrite

	pop {pc}
	
