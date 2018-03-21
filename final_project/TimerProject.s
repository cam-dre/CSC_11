// ===================================================================================================================
// Assignment - Final Project
// ===================================================================================================================
// Programmers: Cameron Perry, Jason Caceres, Henghui Nmi He
// Class: CSC 11
// ===================================================================================================================
.equ LOW, 0
.equ HIGH, 1
.equ OUTPUT, 1
.equ INPUT, 0

.section .data
.balign 4
delayMs: .int   1000
delayIn: .int   3000
delayLt: .int   250
pin1:    .int   7
pin2:    .int   0
pin3:	 .int   25
pin4:    .int   21
pin5: 	 .int   6 
i:       .int   0

message_intro: .asciz "Welcome to our Timer Project\nPlease enter a number that is less than or equal to 60 to countdown from: "
number_start : .asciz "Countdown from: %d\n"
start_message: .asciz "Press the button to start the timer.\n"
integer: .asciz "%d"
timeUp:  .asciz  "Times up!\n"
output: .asciz "%d\n"

array: .skip 240 				// 240 bytes of space cleared for 60 second words
int1: .word 0

.section .text
.balign 4
.global main

main:
	push 	{r4, lr}			// register r4 and lr pushed on to stack
	bl 	wiringPiSetup			// initializing witringPi library

	ldr 	r0, =message_intro		// intro message is displayed to user	
	bl 	printf

	ldr 	r0, =integer			// user is propmted to enter an int	
	ldr 	r1, =int1
	bl 	scanf

	ldr 	r0, =number_start		// displays the user entered
	ldr 	r1, =int1
	ldr 	r1, [r1]
	bl 	printf

	ldr     r0, =pin5
	ldr     r0, [r0]
	mov     r1, #INPUT
	bl      pinMode

	ldr     r0, =start_message
	bl      printf
	
	ldr r0, =i
	ldr r0, [r0]
switch: 					// This is a loop that will continue the user presses the switch
	cmp r0, #HIGH
	beq switch_done
	ldr r0, =pin5 
	ldr r0, [r0]
	bl digitalRead
	bal switch

switch_done:

	ldr 	r4, =int1			// loading users interger into into r4 for comparison in array-Loop
	ldr 	r4, [r4]

timer_Loop:
	cmp r4, #-1 				// this is the actual timer countdown is printed in 1 sec intervals
	beq	timer_done			// loop ends when r4 = -1 after countdown has reached and displayed
	mov 	r1, r4				// a zero
	ldr 	r0, =output
	mov 	r1, r4
	bl	printf

	ldr     r0, =delayMs
        ldr     r0, [r0]
        bl      delay	

	sub r4, #1				// increment index by 1										
	bal timer_Loop				// jump back up to timer_loop for next element

timer_done:
	pop {r4}
	bl light

light:  					// when the timer is complete the user is prompted
	push    {r4, r5}       			// and the lights are put into output mode
                             
        ldr     r0, =timeUp      
        bl      printf

        ldr     r0, =pin1
        ldr     r0, [r0]
        mov     r1, #OUTPUT
        bl      pinMode

	ldr	r0, =pin2
	ldr	r0, [r0]
	mov	r1, #OUTPUT
	bl	pinMode

	
	ldr	r0, =pin3
	ldr	r0, [r0]
	mov	r1, #OUTPUT
	bl	pinMode

	
	ldr	r0, =pin4
	ldr	r0, [r0]
	mov	r1, #OUTPUT
	bl	pinMode
	
        ldr     r4, =i
        ldr     r4, [r4]
        mov     r5, #10

blink_Loop:					// this loop makes the lights flash rapidly signaling
        cmp     r4, r5				// that the timer is up
	bgt     done				
        
        ldr     r0, =pin1
        ldr     r0, [r0]
        mov     r1, #HIGH	 
        bl      digitalWrite

	ldr	r0, =pin2
	ldr	r0, [r0]
	mov	r1, #HIGH
	bl	digitalWrite

	
	ldr	r0, =pin3
	ldr	r0, [r0]
	mov	r1, #HIGH
	bl	digitalWrite
        

	ldr	r0, =pin4
	ldr	r0, [r0]
	mov	r1, #HIGH
	bl	digitalWrite

	
        ldr     r0, =delayLt
        ldr     r0, [r0]
        bl      delay

        ldr     r0, =pin1
        ldr     r0, [r0]
        mov     r1, #LOW
        bl      digitalWrite


	ldr	r0, =pin2
	ldr	r0, [r0]
	mov	r1, #LOW
	bl	digitalWrite
	
	
	ldr	r0, =pin3
	ldr	r0, [r0]
	mov	r1, #LOW
	bl	digitalWrite


	
	ldr	r0, =pin4
	ldr	r0, [r0]
	mov	r1, #LOW
	bl	digitalWrite
	
        ldr     r0, =delayLt
        ldr     r0, [r0]
        bl      delay

        add     r4, #1
        bal     blink_Loop
        
done:   
        mov r0, #0
	pop  {r4,r5,pc} 
