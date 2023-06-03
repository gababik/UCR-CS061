
;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 8 EX 2
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

; This code accepts a character as input, converts it to its binary representation and prints it out, 
; then calculates the number of 1's in the binary representation and displays the count.

; Start of program at address x3000
.ORIG x3000
	LEA R0, intro ; Load the address of the 'intro' message into R0
	PUTS ; Print the string pointed to by R0

	GETC ; Get a character from the input and store it in R0
	OUT ; Print the character stored in R0

	LD R1, SUB_PRINT ; Load the starting address of the SUB_PRINT subroutine into R1
	JSRR R1 ; Jump to SUB_PRINT subroutine and save return location in R1

HALT ; Stop the program
	intro .STRINGZ "ENTER ONE CHARACTER\n" ; Define a null-terminated string for the intro message
	SUB_PRINT .FILL x3200 ; Store the start address of SUB_PRINT subroutine
.END

; SUB_PRINT subroutine begins at x3200. This subroutine prints out the 2's complement of the user input character in binary.
.ORIG x3200	
	ST R7, BU_R7_PRINT ; Save the contents of R7 (return address) before entering the subroutine
	ST R1, BU_R1_PRINT ; Save the contents of R1
	ST R0, BU_R0_PRINT ; Save the contents of R0 (user input)

	ADD R1, R0, #0 ; Copy the contents of R0 (user input) to R1

	LEA R0, NEWLINE ; Load the address of the newline string into R0
	PUTS ; Print the newline string
	LD R0, ASCII_b ; Load the ASCII value for 'b' into R0
	OUT ; Print 'b'

	LD R3, DEC_15 ; Load the decimal value 15 into R3
	LD R5, DEC_4 ; Load the decimal value 4 into R5
	LD R4, DEC_0 ; Load the decimal value 0 into R4

; A loop that prints out the binary representation of the user input character
DO_WHILE ; This is the start of a do-while loop
	ADD R1, R1, R4 ; Add the value in R4 (which is initially 0) to R1 (which holds the ASCII value of the input character)
	BRzp IF_POS ; If the result is zero or positive, branch to the label IF_POS
	BRn END ; If the result is negative, branch to the label END
IF_POS
	LD R0, ASCII_0 ; Load the ASCII value for '0' into R0
	OUT ; Print '0'
END
	BRn IF_NEG ; If the value in the condition code register is negative, branch to the label IF_NEG
	BRzp END2 ; If the value in the condition code register is zero or positive, branch to the label END2
IF_NEG
	LD R0, ASCII_1 ; Load the ASCII value for '1' into R0
	OUT ; Print '1'
END2
	ADD R4, R1, #0 ; Copy the value in R1 (the updated ASCII value of the input character) into R4
	ADD R5, R5, #-1 ; Decrement R5 by 1. R5 is used as a counter for printing space every 4 bits
	BRz IF_4 ; If the result (value in R5) is zero, branch to the label IF_4
	BRnp END3 ; If the result is non-negative or positive, branch to the label END3
IF_4
	LD R0, SPACE ; Load the ASCII value for space into R0
	OUT ; Print a space
	LD R5, DEC_4 ; Reset R5 to 4
END3
	ADD R3, R3, #-1 ; Decrement R3 by 1. R3 is used as a counter for the do-while loop
	BRnp DO_WHILE ; If the result (value in R3) is non-negative or positive, branch back to the label DO_WHILE, repeating the loop
END_DO_WHILE

	ADD R1, R1, R4 ; Add the value in R4 (which is the updated ASCII value of the input character) to R1
	BRzp IF_POS2 ; If the result is zero or positive, branch to the label IF_POS2
	BRn END4 ; If the result is negative, branch to the label END4
IF_POS2
	LD R0, ASCII_0 ; Load the ASCII value for '0' into R0
	OUT ; Print '0'
END4
	BRn IF_NEG2 ; If the value in the condition code register is negative, branch to the label IF_NEG2
	BRzp END5 ; If the value in the condition code register is zero or positive, branch to the label END5
IF_NEG2
	LD R0, ASCII_1 ; Load the ASCII value for '1' into R0
	OUT ; Print '1'
END5


LEA R0, NEWLINE
PUTS
	LD R0, BU_R0_PRINT
	LD R1, BU_R1_PRINT

	LD R2, SUB_COUNT
	JSRR R2

	LEA R0, NEWLINE
	PUTS

	LD R7, BU_R7_PRINT

RET
; Data section for the SUB_PRINT subroutine
ASCII_0 .FILL #48 ; ASCII code for '0'
ASCII_1 .FILL #49 ; ASCII code for '1'
ASCII_b .FILL #98 ; ASCII code for 'b'

DEC_15 .FILL #15 ; Decimal number 15
DEC_4 .FILL #4 ; Decimal number 4
DEC_0 .FILL #0 ; Decimal number 0

SPACE .FILL #32 ; ASCII code for space
NEWLINE .STRINGZ "\n" ; String containing a newline character

SUB_COUNT .FILL x3400 ; Address of the SUB_COUNT subroutine
BU_R0_PRINT .BLKW #1 ; Backup of R0
BU_R1_PRINT .BLKW #1 ; Backup of R1
BU_R7_PRINT .BLKW #1 ; Backup of R7
.END

; SUB_COUNT subroutine begins at x3400. This subroutine counts the number of 1's in the binary representation of the user input character.
.ORIG x3400	
	ST R7, BU_R7_COUNT ; Save the contents of R7 (return address) before entering the subroutine
	ST R0, BU_R0_COUNT ; Save the contents of R0 (user input)

	AND R1, R1, #0		; Reset R1 to 0 to use it as a counter

	ADD R3, R0, #0		; Copy the contents of R0 (user input) to R3
	BRzp NEXT
	ADD R1, R1, #1
NEXT
	AND R2, R2, #0
	ADD R2, R2, #-15	; Initialize R2 to -15 to use it as a bit counter
LOOP
	ADD R3, R3, R3		; Shift the bits of R3 to the left (equivalent to multiplying by 2)
	BRzp AGAIN
	ADD R1, R1, #1
AGAIN
	ADD R2, R2, #1		; Increment the bit counter
	BRn LOOP

	LEA R0, count
	PUTS

	LD R3, ASCII
	ADD R0, R1, R3
	OUT
	
	LD R0, BU_R0_COUNT
	LD R7, BU_R7_COUNT
RET
	count .STRINGZ "NUMBER OF 1'S: "
	BU_R0_COUNT .BLKW #1
	BU_R7_COUNT .BLKW #1
	ASCII .FILL #48
.END
