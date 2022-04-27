@ add the contents of r0 and r1

	.globl	add2
add2:
	add		r1, r1, r0

	mov		pc, lr
