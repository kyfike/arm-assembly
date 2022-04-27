        .data
strFlag:.asciz "\nThe flags are: %08x\n"
	.align 	2 
strHex:	.asciz "%08x"	
	.align	2
strNum: .asciz "%d"
	.align 2
strA1:.asciz "The answer to problem 1 is: %d\n"
	.align 2
strPrompt:.asciz "Enter a number: "
	.align 2
strPrompt2:.asciz "Enter a second number: " 
	.align 2  
strA2mi:.asciz "Since the a < b, then a + 1 = %d and b + 1 = %d\n"
	.align 2
strA2hi:.asciz "Since a > b, then a - 1 = %d and b - 1 = %d\n"
	.align 2
strA2eq:.asciz "Since a == b, then a * 2 = %d and b * 2 = %d\n"
	.align 2

a:      .word 	0 
b:	.word	0

        .text
        .globl main

main:   stmfd   sp!, {lr}       
 
	@PROBLEM #1	
	@GET USER INPUT
	@prompt
	ldr 	r0, =strPrompt   
	bl 	printf

	@scan the input
	ldr 	r0, =strNum
	ldr 	r1, =a  
	bl 	scanf

	@store it
	ldr r3, =a 
	ldr r3, [r3]

	@LOOP 
	@initialize the accumulator and counter		
	mov r0, #0
	mov r1, #1
loop:	cmp	r1, r3 
	beq end
	add r0, r0, r1
	add r1, r1, #1
	b	loop
			
	end:
	@print out result 
	mov 	r1, r0  	
	ldr	r0, =strA1 
	bl 	printf

	@PROBLEM 2
	@prompt imput
	ldr 	 r0, =strPrompt	
	bl 	printf

	@scan input
	ldr 	r0, =strNum
	ldr 	r1, =b
	bl scanf

	@store it
	ldr r4, =b
	ldr r4, [r4] 

	@load 'a' into a register
	ldr r9, =a
	ldr r9, [r9]

	@using 'a' as second compare value 	
	subs	r5, r9, r4 @r9 = a, r4 = b 
	addmi	r9, r9, #1
	addmi	r4, r4, #1
	addhi  	r9, r9, #-1 
	addhi 	r4, r4, #-1
	addeq	r6, r9, r9
	addeq 	r7, r4, r4


	@printing out 
	movmi	r1, r9 @move 'a' into the correct register 
	movmi	r2, r4 @move 'b' "
	movhi 	r1, r9 
	movhi	r2, r4
	moveq	r1, r6 @'a'
	moveq	r2, r7 @'b'
	ldrmi 	r0, =strA2mi
	ldrhi	r0, =strA2hi
	ldreq	r0, =strA2eq
	bl 	printf

	@printing flags
	mrs 	r1, CPSR
	ldr 	r0, =strFlag
	bl 	printf
	
	
	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
