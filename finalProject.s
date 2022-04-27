@ Final Project - Ky Fike - Apr 14, 2022
        
        .data
strIntro:.asciz "\n\n\n\n\n\n\n\n\n\n\t\t\t\t\tUNSCRAMBLE: A PUZZLE GAME\n\n\nYour mental abilites are about to be tested. Upon level selection, you will see a mix of random letters. It is your mission to use all the letters and form a single word!\n\n\tTake note, Player:\n\t\tThere is only one solution for each scramble.\n\t\t... Hit the 'enter' key to submit an answer.\n\t\tSubmit your answer in two parts: enter the first 4 letters first, then the rest.\n\t\tGOOD LUCK!"
	.align 2
strLvl:.asciz "\n\n\nLEVEL SELECTION:\n1: Easy\n2: Medium\n3: Hard\n" 
	.align 2  
strF:.asciz "Oops. Try again!\n"	@ false
	.align 2
strT:.asciz	"CORRECT!"	@ true
	.align 2
strU:.asciz "\n\nUNSCRAMBLE: %s\n"	@ output jumbled letters to be solved
	.align 2
strIS:.asciz "%s"	@ input string
	.align 2
strIX:.asciz "%x"	@ input hex
	.align 2
	
lvS:.word 	0
in:	.word	0
in2:.word	0
						@ Level 1
a11:.word	0x676f6c	@log
	.align  2
a1:	.asciz	"olg"
	.align  2
a21:.word	0x656b696c	@like-s
a22:.word	0x73		
a2:	.asciz	"seilk"
	.align 	2
a31:.word	0x656d6f73	@ some
a3:	.asciz	"meos"
	.align  2
a41:.word	0x74726964	@ dirt
a4:	.asciz	"ditr"
	.align  2
a51:.word	0x656b6163	@ cake
a5:	.asciz	"kace"
	.align  2
aD:	.asciz "\nYou beat the EASY level: 'Log likes some dirt cake!' ... I wish I had a pet log named Log.\n"
	.align 2
						@ Level 2
b11:.word	0x73646166	@ fads
b1:	.asciz	"sdfa"
	.align 	2
b21:.word	0x6f6d6c61	@ almo-st
b22:.word	0x7473	
b2:	.asciz	"aomlts"
	.align 	2
b31:.word	0x6e616863	@ chan-ge
b32:.word	0x6567	
b3:	.asciz	"hgcena"
	.align 	2
b41:.word	0x72756f79	@ your
b4:	.asciz	"uyro"
	.align 	2
b51:.word	0x696f6863	@ choi-ces
b52:.word	0x736563
b5:	.asciz	"hceisco"
	.align 	2
bD:	.asciz "\nYou beat the MEDIUM level: 'Fads almost change your choices.' #ProgrammingIsAFad\n"
	.align 2
						@ Level 3
c11:.word	0x706d6f63	@ comp-uter
c12:.word	0x72657475
c1:	.asciz	"pocmrtue"
	.align 	2
c21:.word	0x64757473	@ stud-ents
c22:.word	0x73746e65
c2:	.asciz	"dssttneu"
	.align 	2
c31:.word	0x70706168	@ happ-ily
c32:.word	0x796c69
c3:	.asciz	"hiyalpp"
	.align 	2
c41:.word	0x7261656c	@ lear-ning
c42:.word	0x676e696e
c4:	.asciz	"ilngraen"
	.align 	2
c51:.word	0x65737361	@ asse-mbly
c52:.word	0x796c626d
c5:	.asciz	"amsesylb"
	.align 	2
cD:	.asciz "\nCONGRADULATIONS: you've beaten the HARD level! I'm sure that you are a part of the group of 'computer students happily learning assembly.'\n\n\n\n"
	.align 2

	
        .text
        .globl main

main:   stmfd   sp!, {lr}       
	@ intro
	ldr	r0, =strIntro  
	bl 	printf
	
	@ level printing and selection - the program will branch back to this location upon level completion
lvl:ldr r0, =strLvl
	bl	printf

	ldr	r0,	=strIX
	ldr	r1,	=lvS
	bl	scanf

	ldr r4, =lvS
	ldr	r4, [r4]
	cmp	r4, #2		@ Only compare level selection to '2' because the level will be less than, equal to, or greater than it!
	blt	l1
	beq	l2
	bgt	l3


					@ NOTE: The rest of the program follows the same format as level 1-1 and 1-2.
					@		Only the variable and loop names change.
l1:
@LEVEL 1-1 LOG
	ldr	r0, =strU
	ldr r1, =a1
	bl	printf

e11:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in		@ The computer automatically stores the user input in hex. In the .data section, I converted
	bl	scanf		@ the answer strings to hex. This makes comparison of having a correct/wrong input possible.
	
	ldr r4, =a11	@ Store the answer (in hexadecimal) in a register.
	ldr	r4, [r4]
	ldr r5, =in		@ Store the user guess--
	ldr r5, [r5]
	cmp r4, r5		@ Compare the answer vs user guess. 
	ldreq r0, =strT	@ True: let the user know, and move on to the next word.
	bne	e11			@ Wrong: loop to let user try again.
	bl	printf

	
@LEVEL 1-2 LIKES
	ldr	r0, =strU
	ldr r1, =a2
	bl	printf

n12:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =a21 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e12
	ldr r6, =a22 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e12:bne	n12
	ldreq r0, =strT
	bl	printf


@LEVEL 1-3 SOME
	ldr	r0, =strU
	ldr r1, =a3
	bl	printf

e13:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r4, =a31
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	ldreq r0, =strT
	bne	e13
	bl	printf

@LEVEL 1-4 DIRT
	ldr	r0, =strU
	ldr r1, =a4
	bl	printf

e14:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r4, =a41
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	ldreq r0, =strT
	bne	e14
	bl	printf

@LEVEL 1-5 CAKE
	ldr	r0, =strU
	ldr r1, =a5
	bl	printf

e15:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r4, =a51
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	ldreq r0, =strT
	bne	e15
	bl	printf
	
	ldr	r0, =aD		@ level done text
	bl	printf
	beq lvl
	

l2:
@ LEVEL 2-1
	ldr	r0, =strU
	ldr r1, =b1
	bl	printf

e21:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r4, =b11
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	ldreq r0, =strT
	bne	e21
	bl	printf
	
@ LEVEL 2-2
	ldr	r0, =strU
	ldr r1, =b2
	bl	printf

n22:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =b21 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e22
	ldr r6, =b22 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e22:bne	n22
	ldreq r0, =strT
	bl	printf

@ LEVEL 2-3
	ldr	r0, =strU
	ldr r1, =b3
	bl	printf
n23:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =b31 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e23
	ldr r6, =b32 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e23:bne	n23
	ldreq r0, =strT
	bl	printf

@ LEVEL 2-4
	ldr	r0, =strU
	ldr r1, =b4
	bl	printf

e24:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r4, =b41
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	ldreq r0, =strT
	bne	e24
	bl	printf
	
@ LEVEL 2-5
	ldr	r0, =strU
	ldr r1, =b5
	bl	printf
n25:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =b51 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e25
	ldr r6, =b52 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e25:bne	n25
	ldreq r0, =strT
	bl	printf
	
	ldr	r0, =bD		@ level done text
	bl	printf
	beq lvl
	
l3:
@ LEVEL 3-1
	ldr	r0, =strU
	ldr r1, =c1
	bl	printf

n31:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =c11 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e31
	ldr r6, =c12 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e31:bne	n31
	ldreq r0, =strT
	bl	printf
	
@ LEVEL 3-2
	ldr	r0, =strU
	ldr r1, =c2
	bl	printf

n32:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =c21 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e32
	ldr r6, =c22 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e32:bne	n32
	ldreq r0, =strT
	bl	printf

@ LEVEL 2-3
	ldr	r0, =strU
	ldr r1, =c3
	bl	printf
n33:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =c31 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e33
	ldr r6, =c32 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e33:bne	n33
	ldreq r0, =strT
	bl	printf

@ LEVEL 2-4
	ldr	r0, =strU
	ldr r1, =c4
	bl	printf
n34:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =c41 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e33
	ldr r6, =c42 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e34:bne	n34
	ldreq r0, =strT
	bl	printf
	
@ LEVEL 2-5
	ldr	r0, =strU
	ldr r1, =c5
	bl	printf
n35:ldr	r0, =strF
	blne printf
	
	ldr r0, =strIS
	ldr	r1, =in
	bl	scanf
	
	ldr r0, =strIS
	ldr	r1, =in2
	bl	scanf
	
	ldr r4, =c51 @ compare the first 4 letters of the word
	ldr	r4, [r4]
	ldr r5, =in
	ldr r5, [r5]
	cmp r4, r5
	bne	e35
	ldr r6, =c52 @ compare the second half of the word
	ldr	r6, [r6]
	ldr r7, =in2
	ldr r7, [r7]
	cmp	r6, r7
e35:bne	n35
	ldreq r0, =strT
	bl	printf
	
	ldr	r0, =cD		@ level done text
	bl	printf
	
	@BEANS	
        ldmfd   sp!, {lr}
        mov     r0, #0
        mov     pc, lr
        .end
