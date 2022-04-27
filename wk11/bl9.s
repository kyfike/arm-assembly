@ Ky Fike
@ April 22, 2022

@ This program prints out the numbers from 1-7, using r1-r3 and the sp. 

        .data
strPrint7: .asciz "%d, %d, %d, %d, %d, %d, and %d\n"
	.align 2
strPrint3: .asciz "%d, %d, %d\n"
	.align 2
strNum: .asciz "%d"
	.align 2
strPrompt:.asciz "Enter a number: "
	.align 2
strIn:.asciz "Enter a number: " 
	.align 2

i:	.word	3				@ 'i' is a sentinel variable. When n = 3, it should stop storing values in the stack
n:	.word	7				@ because 1-3 are manually stored in r1-r3. We subtract 1 from 'n' for each iteration.

        .text
        .globl main

main:   stmfd   sp!, {lr}   

	ldr		r5, =i
	ldr		r5, [r5]

	ldr		r0, =strPrint7
	mov		r1, #1
	mov		r2, #2
	mov		r3, #3

	
	ldr		r4, =n			@ r4 starts by holding 7, the last variable to print, in the stack.
	ldr		r4, [r4]
nextnum:
	sub		sp, sp, #4		@ Moves to the next address in the stack.
	str		r4, [sp]		@ Stores a value in the stack.
	sub		r4, r4, #1		@ Subtracts 1.
	cmp		r4, r5			@ Tests against sentinel variable.
	bne		nextnum
	bl		printf
	add		sp, sp, #16		@ 4 bytes * 4 numsToStore = 16


	ldmfd   sp!, {lr} 		@ closing
    mov     r0, #0
    mov     pc, lr
    .end
