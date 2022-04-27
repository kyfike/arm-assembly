        .data
strNum: .asciz "%d"
	.align 2
strPrompt:.asciz "Enter a number (a): "
	.align 2
strPrompt2:.asciz "Enter a number (b): " 
	.align 2  
strPN:.asciz "This is problem %d:\n"
	.align 2
strC:.asciz "c = %d\n"
	.align 2
strS:.asciz "A and B (stored and added from the stack) have the sum of: %d\n"
	.align 2

a:	.word 	0 
b:	.word	0
c:	.word	0
ctr:.word	0

        .text
        .globl main

main:   stmfd   sp!, {lr}       
 
	@ PROBLEM 3
	@ prompt and save user input
	ldr 	r0, =strPrompt   
	bl		printf

	@ scan the input
	ldr 	r0, =strNum
	ldr 	r1, =a  
	bl 		scanf

	@ store 'a'
	ldr 	r7, =a 
	ldr 	r7, [r7]

	@ prompt
	ldr 	 r0, =strPrompt2	
	bl 		printf

	@ scan the input
	ldr 	r0, =strNum
	ldr 	r1, =b
	bl 		scanf

	@ store 'b'
	ldr 	r8, =b
	ldr 	r8, [r8]
	
	@ store sum
	add		r6, r7, r8

	@ COMPARISONS WITH BRANCHING
	ldr 	r1, =ctr	@ print problem number
	ldr		r1, [r1]
	add		r1, r1, #3
	ldr		r0, =strPN
	bl 		printf
	
		@ 'a' = r7, 'b' = r8, 'a + b' = r6
		@ OR sum > 8
	cmp		r6, #8 
	bgt 	c5
		@ a >= 2 AND b <= 5
	cmp 	r7, #2
	bge		pt2
	blt		c10
pt2:cmp 	r8, #5
	bls		c5
	bgt		c10
c10:mov 	r1, #10
	b		stop
c5:	mov 	r1, #5
stop:ldr		r0, =strC
	bl 		printf

	@ COMPARISONS WITHOUT BRANCHING
	@ 'a' = r7, 'b' = r8, 'c' = r9, 'a + b' = r6
	mov		r9, #10	@ set c to the else case and work backwards testing other conditions
	cmp		r7, #2
	movge	r9, #5  @ A true, set c = 5
	cmp		r8, #5
	movgt	r9, #10	@ B false, c = 10 (otherwise c would still = 5)
	cmp		r6, #8
	movgt	r9, #5	@ the OR is true, c = 5
	ldr		r0,	=strC
	mov		r1, r9
	bl		printf
	
	
	@ PROBLEM 4 (WITH BRANCHING)
	ldr 	r1, =ctr	@ print problem number
	ldr		r1, [r1]
	add		r1, r1, #4
	ldr		r0, =strPN
	bl 		printf
	
	@ 'a' = r7, 'b' = r8, 'c' = r9
	cmp		r7, #0
	blt		fork3
	cmp		r8, #0
	bgt		fork3
	cmp		r7, #4
	movge	r9, #-1
	movlt	r9, #-2
	b	end
fork3:
	cmp		r8, #3
	movge	r9, #-3
	movlt	r9, #-4
end:ldr		r0,	=strC @ print it
	mov		r1, r9
	bl		printf


	@ PROBLEM 5 & 6 (TWO NUMS ON STACK)
	ldr 	r1, =ctr	@ print problem number
	ldr		r1, [r1]
	add		r1, r1, #6
	ldr		r0, =strPN
	bl 		printf
	
	sub		sp, sp, #4
	str		r7, [sp]
	sub		sp, sp, #4
	str		r8, [sp]
	ldr		r5, [sp]	@ access second value in the stack
	sub		sp, sp, #-4	@ move the stack pointer
	ldr		r4, [sp]	@ first value ...
	sub		sp, sp, #-4	@ and the stack pointer is now reset
	add		r1, r4, r5
	ldr 	r0, =strS
	bl		printf


	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
