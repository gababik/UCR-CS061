;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 5 EX 2
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000
; main program starts here
LD R0, addr ; Load the address of data into R0
LD R1, SUB_GET_STRING ; Load the address of SUB_GET_STRING subroutine into R1
JSRR R1 ; Jump to the subroutine and store the return address in R7

LD R1, SUB_IS_PALINDROME ; Load the address of SUB_IS_PALINDROME subroutine into R1
JSRR R1 ; Jump to the subroutine and store the return address in R7

LD R2, DEC_ONE ; Load the decimal value 1 into R2
NOT R2, R2 ; Perform bitwise NOT operation on R2
ADD R2, R2, #1 ; Add 1 to R2 to get -1 (Two's complement representation)
ADD R4, R4, R2 ; Subtract 1 from R4
BRz PRINT ; If R4 is zero (i.e., the string is a palindrome), branch to PRINT

LEA R0, NON_PALINDROME ; Load the address of NON_PALINDROME string into R0
PUTS ; Print the string pointed by R0
HALT ; Halt the program

; Subroutine to print the result if the string is a palindrome
PRINT
LEA R0, PALINDROME ; Load the address of PALINDROME string into R0
PUTS ; Print the string pointed by R0
HALT ; Halt the program

; Data section starts here
HALT
addr .FILL x4000 ; Address of the character array
SUB_GET_STRING .FILL x3200 ; Address of SUB_GET_STRING subroutine
SUB_IS_PALINDROME .FILL x3400 ; Address of SUB_IS_PALINDROME subroutine
DEC_ONE .FILL #1 ; Decimal value 1
PALINDROME .STRINGZ "What the user inputted is indeed a palindrome\n" ; String for palindrome
NON_PALINDROME .STRINGZ "What the user inputted is NOT a palindrome\n" ; String for non-palindrome
.END
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
; terminated by the [ENTER] key (the "sentinel"), and has stored
; the received characters in an array of characters starting at (R1).
; the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
; R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------

.ORIG x3200
ST R0, BACKUP_R0_3200 ; Store R0 to a backup register
ST R1, BACKUP_R1_3200 ; Store R1 to a backup register
ST R7, BACKUP_R7_3200 ; Store R7 to a backup register

LEA R0, PROMPT_3200 ; Load the address of the prompt string into R0
PUTS ; Print the prompt string

LD R1, BACKUP_R0_3200 ; Restore R0 from backup register
AND R5, R5, #0 ; Initialize R5 to zero (count of non-sentinel characters)
LD R2, NEWLINE ; Load the newline character into R2

NOT R2, R2 ; Perform bitwise NOT operation on R2
ADD R2, R2, #1 ; Add 1 to R2 to get -newline (Two's complement representation)

; Start of loop to read characters from user input
LOOP1
GETC ; Get character from input and store it in R0
OUT ; Output the character to the console
ADD R3, R0, R2 ; Add -newline to the input character
BRz RESET ; If the input character is a newline, branch to RESET

STR R0, R1, #0 ; Store the input character in the array
ADD R1, R1, #1 ; Increment the array pointer
ADD R5, R5, #1 ; Increment the count of non-sentinel characters

BRnzp LOOP1 ; Repeat the loop for more characters
END_LOOP1

; End of loop for reading characters

RESET
LD R0, ZERO ; Load zero into R0
STR R0, R1, #0 ; NULL-terminate the array

LD R0, BACKUP_R0_3200 ; Restore R0 from backup register
LD R1, BACKUP_R1_3200 ; Restore R1 from backup register
LD R7, BACKUP_R7_3200 ; Restore R7 from backup register
RET ; Return from subroutine

; Data section for SUB_GET_STRING subroutine
HALT
PROMPT_3200 .STRINGZ "This is ex 2 Please enter some words (Press enter to finish upon completion: \n"
NEWLINE .FILL x0A ; ASCII code for newline character
ZERO .FILL #0 ; Decimal value 0
BACKUP_R0_3200 .BLKW x1 ; Backup register for R0
BACKUP_R1_3200 .BLKW x1 ; Backup register for R1
BACKUP_R7_3200 .BLKW x1 ; Backup register for R7
.END

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
; is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------

.ORIG x3400
ST R1, BACKUP_R1_3400 ; Store R1 to a backup register
ST R7, BACKUP_R7_3400 ; Store R7 to a backup register

ADD R1, R0, R5; Add the number of characters to the array pointer
ADD R1, R1, #-1 ; Decrement the array pointer to point at the last character

; Start of loop to compare characters in the string
SUB_LOOP
LDR R2, R0, #0 ; Load the character at the beginning of the string into R2
LDR R3, R1, #0 ; Load the character at the end of the string into R3
NOT R4, R1 ; Perform bitwise NOT operation on R1
ADD R4, R4, #1 ; Add 1 to R4 to get -R1 (Two's complement representation)
ADD R4, R0, R4 ; Calculate the difference between the array pointers
BRz SUCCESS ; If the pointers are equal, the string is a palindrome; branch to SUCCESS

NOT R3, R3 ; Perform bitwise NOT operation on R3
ADD R3, R3, #1 ; Add 1 to R3 to get -R3 (Two's complement representation)
ADD R2, R2, R3 ; Compare the characters at the beginning and end of the string
BRnp FAILURE ; If the characters are not equal, the string is not a palindrome; branch to FAILURE

ADD R4, R4, #-1 ; Decrement R4
BRz SUCCESS ; If R4 is zero, the string is a palindrome; branch to SUCCESS

ADD R0, R0, #1 ; Increment the array pointer at the beginning
ADD R1, R1, #-1 ; Decrement the array pointer at the end
BRnzp SUB_LOOP ; Continue the loop for remaining characters

; End of loop for comparing characters

; If the string is a palindrome
SUCCESS
LD R4, DEC_ONE_3400 ; Load decimal value 1 into R4
LD R1, BACKUP_R1_3400 ; Restore R1 from backup register
LD R7, BACKUP_R7_3400 ; Restore R7 from backup register
RET ; Return from subroutine

; If the string is not a palindrome
FAILURE
LD R4, DEC_ZERO_3400 ; Load decimal value 0 into R4
LD R1, BACKUP_R1_3400 ; Restore R1 from backup register
LD R7, BACKUP_R7_3400 ; Restore R7 from backup register
RET ; Return from subroutine

; Data section for SUB_IS_PALINDROME subroutine
HALT
DEC_ONE_3400 .FILL #1 ; Decimal value 1
DEC_ZERO_3400 .FILL #0 ; Decimal value 0
BACKUP_R1_3400 .BLKW #1 ; Backup register for R1
BACKUP_R7_3400 .BLKW #1 ; Backup register for R7
.END