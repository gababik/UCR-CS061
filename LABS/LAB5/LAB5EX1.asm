;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 5 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000
;main
LD R0, addr ; Load the address of data memory into R0
LD R1, String ; Load the address of the subroutine String into R1

JSRR R1 ; Jump to the subroutine String
PUTS ; Print the string in the data memory

HALT ; Stop the program
;DATA
addr .FILL x4000 ; Declare a label "addr" and store the address x4000
String .FILL x3200 ; Declare a label "String" and store the address x3200
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
ST R0, BACKUP_R0_3200 ; Save R0 to memory
ST R1, BACKUP_R1_3200 ; Save R1 to memory
ST R7, BACKUP_R7_3200 ; Save R7 to memory

LEA R0, PROMPT_3200 ; Load the address of the prompt string into R0
PUTS ; Print the prompt string

LD R1, BACKUP_R0_3200 ; Restore R0 from memory
AND R5, R5, #0 ; Clear R5 to store the count of non-sentinel characters
LD R2, NEWLINE ; Load newline character into R2

NOT R2, R2 ; Negate R2
ADD R2, R2, #1 ; Increment R2

LOOP1
GETC ; Get a character from the user
OUT ; Output the character
ADD R3, R0, R2 ; Add R0 and R2 and store the result in R3
BRz RESET ; Branch to RESET if R3 is zero

STR R0, R1, #0 ; Store the character in the array
ADD R1, R1, #1 ; Increment R1
ADD R5, R5, #1 ; Increment R5

BRnzp LOOP1 ; Loop back to LOOP1 if R3 is non-zero
END_LOOP1

BRnzp LOOP1 ; Continue looping if there are more characters to read

RESET
LD R0, ZERO ; Load zero into R0
STR R0, R1, #0 ; Store the null terminator in the array

LD R0, BACKUP_R0_3200 ; Restore R0 from memory
LD R1, BACKUP_R1_3200 ; Restore R1 from memory
LD R7, BACKUP_R7_3200 ; Restore R7 from memory
RET ; Return from the subroutine
HALT
;sub data
PROMPT_3200 .STRINGZ "This is ex 1 Please enter some words (Press enter to finish upon completion: \n"
NEWLINE .FILL x0A ; Declare a label "NEWLINE" and store the newline character (ASCII code 10)
ZERO .FILL #0 ; Declare a label "ZERO" and store the value 0
BACKUP_R0_3200 .BLKW x1 ; Declare a label "BACKUP_R0_3200" and reserve 1 block of memory
BACKUP_R1_3200 .BLKW x1 ; Declare a label "BACKUP_R1_3200" and reserve 1 block of memory
BACKUP_R7_3200 .BLKW x1 ; Declare a label "BACKUP_R7_3200" and reserve 1 block of memory
.END





