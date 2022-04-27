        .data
strNum: .asciz "%d"
	.align 2
strPrompt:.asciz "Enter a number: "
	.align 2
strIn:.asciz "Enter a number: " 
	.align 2

a:	.word	0
b:	.word	0

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
	
	ldr		r0, =a
	ldr		r0, [r0]
	ldr		r1, =b
	ldr		r1, [r1]
	bl 		add2
	ldr		r0, =strNum
	bl		printf
	

	


	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
