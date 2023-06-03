;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 5 EX 3
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
; Main program: Determines if a user inputted string is a palindrome
; by calling two subroutines: SUB_GET_STRING and SUB_IS_PALINDROME
.ORIG x3000

; main program start
; Load the starting address of the string storage into R0
LD R0, addr

; Load the address of the subroutine SUB_GET_STRING into R1 and call it
LD R1, SUB_GET_STRING
JSRR R1

; Load the address of the subroutine SUB_IS_PALINDROME into R1 and call it
LD R1, SUB_IS_PALINDROME
JSRR R1

; Prepare the register R2 for conditional branching
LD R2, DEC_ONE
NOT R2, R2
ADD R2, R2, #1

; Increment R4 by R2 (effectively adding 1 to R4)
ADD R4, R4, R2

; If R4 is zero (input is not a palindrome), branch to PRINT
BRz PRINT

; Print the NON_PALINDROME message and halt the program
LEA R0, NON_PALINDROME
PUTS
HALT

; Print the PALINDROME message and halt the program
PRINT
LEA R0, PALINDROME
PUTS
HALT

; Data section for the main program
HALT
addr .FILL x4000
SUB_GET_STRING .FILL x3200
SUB_IS_PALINDROME .FILL x3400
DEC_ONE .FILL #1
PALINDROME .STRINGZ "What the user inputted is indeed a palindrome\n"
NON_PALINDROME .STRINGZ "What the user inputted is NOT a palindrome\n"

; End of the main program
.END
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.ORIG x3200

; Save registers R0, R1, and R7 for later restoration
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R7, BACKUP_R7_3200

; Print the prompt for user input
LEA R0, PROMPT_3200
PUTS

; Restore the value of R0 (address where the string will be stored)
LD R1, BACKUP_R0_3200

; Clear R5 (counter for characters in the input string)
AND R5, R5, #0

; Load the ASCII code for newline into R2
LD R2, NEWLINE

; Invert R2, add 1 to prepare for comparison
NOT R2, R2
ADD R2, R2, #1

; Start the loop for reading characters from the user
STRING_INPUT_LOOP
; Read a character, print it back to the user, and compare it with the newline character
GETC
OUT
ADD R3, R0, R2

; If the input character is a newline, break the loop and reset
BRz RESET

; Store the input character in the string and increment the address pointer (R1) and character counter (R5)
STR R0, R1, #0
ADD R1, R1, #1
ADD R5, R5, #1

; Continue the loop for more characters
BRnzp STRING_INPUT_LOOP

; End of the input loop
END_STRING_INPUT_LOOP
; Continue the loop for more characters
BRnzp STRING_INPUT_LOOP

; Reset loop by adding null terminator at the end of the string
RESET
LD R0, NONE
STR R0, R1, #0

; Restore the values of R0, R1, and R7 and return to the caller
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R7, BACKUP_R7_3200
RET

; Data section for SUB_GET_STRING
HALT
PROMPT_3200 .STRINGZ "This is ex3 Please enter some words (Press enter to finish upon completion: \n"
NEWLINE .FILL x0A
NONE .FILL #0
BACKUP_R0_3200 .BLKW x1
BACKUP_R1_3200 .BLKW x1
BACKUP_R7_3200 .BLKW x1
.END

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.ORIG x3400

; Save registers R1 and R7 for later restoration
ST R1, BACKUP_R1_3400
ST R7, BACKUP_R7_3400

; Call the subroutine to convert the string to upper case
JSR upper_addr

; Initialize R1 with the address of the last character in the string
ADD R1, R0, R5
ADD R1, R1, #-1

; Start the loop to compare characters in the string
SUB_LOOP
; Load the first and last characters of the string into R2 and R3
LDR R2, R0, #0
LDR R3, R1, #0

; Compare the characters, if they are equal, continue with the next characters
NOT R4, R1
ADD R4, R4, #1
ADD R4, R0, R4
BRz SUCCESS

; If the characters are not equal, the string is not a palindrome
NOT R3, R3
ADD R3, R3, #1
ADD R2, R2, R3
BRnp FAILURE

; If the characters are equal but not the last pair, continue checking
ADD R4, R4, #-1
BRz SUCCESS

; Move the address pointers to the next pair of characters
ADD R0, R0, #1
ADD R1, R1, #-1

; Continue the loop for more characters
BRnzp SUB_LOOP

; If all pairs of characters are equal, the string is a palindrome
SUCCESS
; Load 1 into R4, restore the values of R1 and R7, and return to the caller
LD R4, DEC_ONE_3400
LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400
RET

; If a pair of characters is not equal, the string is not a palindrome
FAILURE
; Load 0 into R4, restore the values of R1 and R7, and return to the caller
LD R4, DEC_ZERO_3400
LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400
RET

; Data section for SUB_IS_A_PALINDROME
HALT
DEC_ONE_3400 .FILL #1
DEC_ZERO_3400 .FILL #0
BACKUP_R1_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1
upper_addr .FILL x3600
.END

;-------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case
;     in-place i.e. the upper-case string has replaced the original string
; No return value, no output, but R1 still contains the array address, unchanged
;-------------------------------------------------------------------------

.ORIG x3600

; Save registers R0, R1, and R7 for later restoration
ST R0, BACKUP_R0_3600
ST R1, BACKUP_R1_3600
ST R7, BACKUP_R7_3600

; Load a constant value into R1 for comparison
LD R1, NONE_3600

; Load the constant for upper-case conversion into R4
LD R4, SUB_ADDR

; Start the loop to convert characters to upper-case
LOOP_TO_UPPER
; Load a character from the string into R2
LDR R2, R0, #0

; Add R1 to R2 for comparison with the null terminator
ADD R3, R2, R1
BRz DONE

; Convert the character to upper-case and store it back in the string
AND R2, R2, R4
STR R2, R0, #0

; Move the address pointer to the next character
ADD R0, R0, #1

; Continue the loop for more characters
BRnzp LOOP_TO_UPPER

; End of the upper-case conversion loop
DONE
; Restore the values of R0, R1, and R7 and return to the caller
LD R0, BACKUP_R0_3600
LD R1, BACKUP_R1_3600
LD R7, BACKUP_R7_3600
RET

; Data section for SUB_TO_UPPER
HALT
NONE_3600 .FILL #0
SUB_ADDR .FILL x5F
BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1
.END