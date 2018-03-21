.fpu neon

.data
x: .float 1.1,2.1,3.1,4.2
y: .float 5.5,6.6,7.7,8.8

.text
.global main
main:
push {lr}
ldr r0, =x
vld1.32 {q0,q1}, [r0]
vmul.f32 q0, q1
see:
pop {pc}
