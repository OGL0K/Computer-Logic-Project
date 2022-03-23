
														@FUNCTIONS
theinput:			@This function creates the input.
    push {lr}			@Link register has been pushed.
    mov r0, #0			@0 has been moved to r0. r0 = 0.
    ldr r1, =input		@load r1 register with the address of input.
    mov r2, #19			@19 has been moved to r2. r2 = 19.
    mov r7, #3			@3 has been moved to r7 to read.
    svc 0			@make the system call.
    pop {lr}			@Link register has been popped.
    bx lr			@Link register has been branched and exchanged.

validation:			@This function validates the appropriate characters.
    ldr r2, =input		@load r2 with the address of input.
    ldrb r3, [r2]		@load byte r3 with the value at input.
    add r2, #1			@adding r2 to 1.
    ldrb r5, [r2]		@load byte r5 with the value at input.
    cmp r5, #10			@comparing r5 to 10.
    bne invalidation		@if r5 is not equal to 10 invalidation function will work.
    cmp r3, #48			@comparing r3 to 48.
    beq exit			@if r3 is equal to 48 exit function will work.
    cmp r3, #65			@comparing r3 to 65.
    blt invalidation		@if r3 is less then 65 invalidation function will work.
    cmp r3, #90			@comparing r3 to 90.
    bxle lr			@if r3 is less than 90 branch and exchange link register.
    cmp r3, #97			@comparing r3 to 97.
    blt invalidation		@if r3 is less than 97 invalidation function will work.
    cmp r3, #122		@comparing r3 to 122.
    bgt invalidation		@if r3 is greater than 122 invalidation function will work.
    suble r3, #32		@if r3 is less than 122 substract 32 from r3.
    suble r2, #1
    strleb r3, [r2]
    bxle lr

invalidation:			@This function prints a text if the character is invalid.
    ldr r0, =invalidationtext	@load word r0 register with the address of invalidationtext.
    bl printf			@branch link printf.
    bl next			@branch link next.

opencourseworkfile:		@This function opens the courseworkfile.
    ldr r0, =file		@load word r0 with the address of file.
    mov r1, #0			@0 has been moved to r1 register. r1 = 0.
    mov r2, #644		@644 has been moved to r2 register. r2 = 644.
    mov r7, #5			@opens the file.
    svc 0			@make the system call.

readcourseworkfile:		@This function reads the courseworkfile.
    ldr r1, =buffer		@load word r1 with the address of buffer.
    mov r2, #139		@139 has been moved to r2. r2 = 139.
    mov r7, #3			@3 has been moved to r7 to read the courseworkfile.
    svc 0			@make the system call.

clsthefile:			@This function closes the courseworkfile.
    mov r7, #6			@6 has been moved r7 to close the courseworkfile.
    svc 0			@make the system call.
    bx lr			@branch and exchange link register.

checkinput:			@This function checks the input.
    ldr r1, =input		@load word r1 with the address of input.
    ldrb r2, [r1]		@load byte r2 with the value at input.
    ldrb r3, [r2]		@load byte r3 with the value at r2.

chooseword:			@This function chooses a word from courseworkfile.
    ldr r0, =buffer		@load word r0 with the address of buffer.
    ldr r1, =strword		@load word r1 with the address of strword.

selectword:			@This function select a word from stored words.
    cmp r2, #0			@comparing r2 to 0.
    beq storewords		@if r2 is equal to 0 branch storewords.
    ldrb r3, [r0] , #1		@load byte r3 with the value at r0 + 1.
    cmp r3, #'\n'		@comparing r3 with '\n'.
    subeq r2, #1		@if r3 is equal to '\n' substract 1 from r2.
    b selectword		@branch selectword.

storewords:			@This function stores the words from courseworkfile.
    ldrb r2,[r0], #1		@load byte r2 with the value at r0 + 1.
    strb r2, [r1], #1		@save byte r2 at r1 + 1.
    cmp r2, #'\n'		@comparing r2 with '\n'.
    bxeq lr			@if r2 is not equal to '\n' branch link register.
    b storewords		@branch storewords.

randominteger:			@This function chooses a random integer between 1 to 15.
    push {lr}			@link register has been pushed.
    mov r0, #0			@0 has been moved to r0. r0 = 0.
    bl time			@branch link time.
    bl srand			@branch link srand.
    bl rand			@brand link rand.
    and r0, r0, #0xF
    cmp r0, #10			@compare r0 to 10.
    subge r0, #10		@if r0 greater than 10 substarct 10 from r0.
    mov r2, r0			@r0 has been moved to r2. r2 = r0.
    pop {lr}			@link register has been popped.
    push {r2}			@r2 register has been pushed.
    bx lr			@branch and exchange link register.

underscores:			@This function creates underscores.
    ldrb r4, [r1]		@load byte r4 with the address of r1.
    cmp r4, #10			@comparing r4 to 10.
    bxeq lr			@if r4 is equal to 10 branch and exchange link register.
    strb r3, [r2]		@save byte r3 at r2.
    add r1, #1			@adding r1 to 1.
    add r2, #1			@adding r2 to 1.
    b underscores		@branch underscores.

wordchecking:			@This function generates underscores by courseworkfile.
    ldr r0, =input		@load byte r0 with the address of input.
    ldrb r0, [r0]		@load byte r0 with the value at r0.
    ldr r1, =underscore		@load r1 with the address of r1.
    ldr r2, =strword		@load r2 with the address of strword.
    mov r4, #0			@0 has been moved to r4.

loopword:			@This function loops the words.
    ldrb r3, [r2], #1		@load byte r3 with the value at r2 + 1.
    cmp r3, #10			@comparing r3 to 10.
    bxeq lr			@if r3 is equal to 10 branch and exchange link register.
    cmp r3, r0			@comparing r3 to r0.
    streqb r0, [r1]		@if r3 is equal to r0 save byte r0 at r0.
    moveq r4, #1		@if r3 is equal to r0 move 1 to the r4 register.
    add r1, #1			@add 1 to the r1 register.
    b loopword			@branch loopword.

loopscore:			@This function loops the underscore and if there are no underscores left winning message will pop.
    ldrb r1, [r0], #1		@load byte r1 with the value at r0 + 1.
    cmp r1, #'_'		@comparing r1 to '_'.
    bxeq lr			@if r1 is equal to '_' branch and exchange link register.
    cmp  r1, #0			@comparing r1 to 0.
    beq winningmessage		@if r1 is equal to 0 winningmessage function will work.
    b loopscore			@branch loopscore.

winningmessage:			@This function will print the winning message.
    ldr r0, =winningtext	@load r0 with the address of winning text.
    bl printf			@branch link printf.
    ldr r0, =printword		@load r0 with the address of printword.
    bl printf			@branch link printf.
    ldr r0, =underscore		@load r0 with the address of underscore.
    bl printf			@branch link printf.
    ldr r0, =newline		@load r0 with the address of newline.
    bl printf			@branch link printf.


exit:				@This function exits the game if the player enters 0 in the input.
    mov R7, #1			@1 has been moved to R7 to exit the program.
    svc 0			@make the system call.

.global main
main:														@MAIN FUNCTION
    bl randominteger		@branch link randominteger.
    bl opencourseworkfile	@branch link opencourseworkfile.
    pop {r2}			@r2 has been popped.
    bl chooseword		@branch link chooseword.
    ldr r0, =strword		@load r0 with the address of strword.
    ldr r1, =strword		@load r1 with the address of strword.
    ldr r2, =underscore		@load r2 with the address of underscore.
    mov r3, #95			@95 has been moved to r3.
    bl underscores		@branch link underscores.
next:
    push {r1}			@r1 register has been pushed.
    ldr r0, =line1		@load r0 with the address of line1.
    bl printf			@branch link printf.
    ldr r0, =line2		@load r0 with the address of line2.
    bl printf			@branch link printf.
    ldr r0, =underscore		@load r0 with the address of underscore.
    bl printf			@branch link printf.
    ldr r0, =line3		@load r0 with the address of line3.
    bl printf			@branch link printf.
    ldr r0, =line4		@load r0 with the address of line4.
    bl printf			@branch link printf.
    ldr r0, =line5		@load r0 with the address of line5.
    bl printf			@branch link printf.
    ldr r0, =line6		@load r0 with the address of line6.
    bl printf			@branch link printf.
    ldr r0, =line7		@load r0 with the address of line7.
    bl printf			@branch link printf.
    ldr r0, =line8		@load r0 with the address of line8.
    bl printf			@branch and link printf.
    ldr r0, =line9		@load r0 with the address of line9.
    bl printf			@branch link printf.
    ldr r0, =line10		@load r0 with the address of line10.
    bl printf			@branch link printf.
    ldr r0, =line11		@load r0 with the address of line11.
    bl printf			@branch link printf.
    bl theinput			@branch link theinput.
    bl validation		@branch link validation.
    bl wordchecking		@branch link wordchecking.
    ldr r0, =underscore		@load r0 with the address of underscore.
    bl loopscore		@branch link loopscore.
    b next			@branch next.
    b exit			@branch next.

    .data													@DATA VARIABLES
    .align 2
    file: .asciz "courseworkwords.txt"
    line1: .asciz "Welcome to the Hangman game made by Oguz Gokyuzu. Good luck and have fun! \n"
    line2: .asciz "    |----------|   Word:  "
    line3: .asciz "\n    |          | \n"
    line4: .asciz "               |   Misses: \n"
    line5: .asciz "               | \n"
    line6: .asciz "               | \n"
    line7: .asciz "               | \n"
    line8: .asciz "               | \n"
    line9: .asciz "               | \n"
    line10:.asciz "  -------------| \n"
    line11: .asciz "Enter your character here or you can also enter 0 to exit the game: \n"
    winningtext: .asciz "Congratulations you won!! \n"
    invalidationtext: .asciz "The character you put is invalid! \n"
    printword: .asciz "The word was: "
    newline: .asciz "\n"

    .bss
    underscore: .space 20
    buffer: .space 140
    input: .space 20
    strword: .space 20
    randomintegerrr: .space 4
    .end
