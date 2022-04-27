        .data
strNum: .asciz "%d"
	.align 2
strPrompt:.asciz "The sum of the numers is: %d"
	.align 2
strIn:.asciz "Enter a number: " 
	.align 2

t:	.word	0
ctr:.word	1

        .text
        .globl main

main:   stmfd   sp!, {lr}       

	mov		r6, #0		@ move 0 to the register where the sum will be calculated
	mov		r9, #0		@ set counter
In:	
	ldr 	r0, =strIn	@ prompt
	bl 		printf
	
	sub		sp, sp, #4	@ prep the stack
	ldr 	r0, =strNum	
	mov 	r1, sp		@ scan the input 
	bl 		scanf
	
	add		r9, r9, #1	@ add 1 to the total number of inputs

	mov		r7, sp		@ is sp the sentinel value?
	ldr		r7, [r7]
	cmp		r7, #-1	
	addeq	sp, sp, #4	@ unsave -1
	subeq	r9, r9, #1	@ uncount -1
	beq		addIns	
	bne		In
addIns:
	mov		r7, sp
	ldr		r7, [r7]
	add		r6, r6, r7
	add		sp, sp, #4	@ step back through the stack	
	sub		r9, r9, #1	@ subtract one from the input counter
	cmp		r9, #0
	bne		addIns
	
	mov		r1, r6		@ print the sum
	ldr		r0, =strPrompt
	bl		printf

	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
