        .data
strPrint4: .asciz "%d, %d, %d, and %d\n"
	.align 2
strNum: .asciz "%d"
	.align 2
strPrompt:.asciz "Enter a number: "
	.align 2
strIn:.asciz "Enter a number: " 
	.align 2

a:	.word	0
b:	.word	0
c:	.word	0
d:	.word	0

        .text
        .globl main

main:   stmfd   sp!, {lr}   

	ldr 	r0, =strPrompt   	@ get user input #1
	bl 	printf

	ldr 	r0, =strNum
	ldr 	r1, =a  
	bl 	scanf
	
	ldr 	r0, =strPrompt   	@ get user input #2
	bl 	printf

	ldr 	r0, =strNum
	ldr 	r1, =b 
	bl 	scanf
	
	ldr 	r0, =strPrompt   	@ get user input #3
	bl 	printf

	ldr 	r0, =strNum
	ldr 	r1, =c 
	bl 	scanf
	
	ldr 	r0, =strPrompt   	@ get user input #4
	bl 	printf

	ldr 	r0, =strNum
	ldr 	r1, =d
	bl 	scanf
	
	ldr		r0, =strPrint4
	ldr		r1, =a
	ldr		r1, [r1]
	ldr		r2, =b
	ldr		r2, [r2]
	ldr		r3, =c
	ldr		r3, [r3]
	sub		sp, sp, #4		@ move to the next address in the stack
	ldr		r4, =d			@ lines 57-59, put the last user input in that new address
	ldr		r4, [r4]
	str		r4, [sp]
	bl		printf
	
	add		sp, sp, #4		@ send the sp to its normal location!

	


	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
