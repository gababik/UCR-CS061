;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 6 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
;main
.Orig x3000
LD R2, NEWLINE ; Load the value of NEWLINE into register R2

NOT R2, R2 ; Perform bitwise NOT operation on R2
ADD R2, R2, #1 ; Increment R2 by 1

LD R4, BASE ; Load the value of BASE (stack base address) into register R4
LD R5, MAX ; Load the value of MAX (stack max address) into register R5
LD R6, TOS ; Load the value of TOS (stack top address) into register R6

; Main loop for user input
WHILE_LOOP
LEA R0, PROMPT ; Load the effective address of PROMPT into R0
PUTS ; Print the string stored at the address in R0 (PROMPT)

GETC ; Get a character from input
OUT ; Output the character

ADD R3, R0, R2 ; Add R0 (input value) and R2 (newline value) to R3
BRz END_LOOP ; If R3 is zero (input is newline), break loop and go to END_LOOP

ST R0, USER_INPUT ; Store the user input value into USER_INPUT
LD R0, NEWLINE ; Load the value of NEWLINE into R0
OUT ; Output a newline character

LD R0, USER_INPUT ; Load the user input value into R0
LD R1, OFFSET ; Load the value of OFFSET into R1
ADD R0, R0, R1 ; Add R0 (user input) and R1 (OFFSET) to R0
LD R1, SUB_STACK_PUSH ; Load the value of SUB_STACK_PUSH into R1
JSRR R1 ; Jump to the subroutine at the address in R1 (SUB_STACK_PUSH)
BRnzp WHILE_LOOP ; If the condition code is not zero, continue the loop

; End of the main loop
END_LOOP
HALT ; Halt the program execution

; Data section for main program
HALT
SUB_STACK_PUSH .FILL x3200 ; Store the address of the SUB_STACK_PUSH subroutine
OFFSET .FILL #-48 ; Store the offset value for converting ASCII input to integer
NEWLINE .FILL x0A ; Store the ASCII value for the newline character
BASE .FILL xA000 ; Store the base address of the stack
MAX .FILL xA005 ; Store the max address of the stack
TOS .FILL xA000 ; Store the top address of the stack
PROMPT .STRINGZ "Enter value to push onto stack\n" ; Store the prompt string
USER_INPUT .BLKW #1 ; Reserve one word for storing user input
.END

;------------------------------------------------------------------------------------------
;Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
; If the stack was already full ( TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R6 updated TOS
;------------------------------------------------------------------------------------------
.Orig x3200
ST R2, BACKUP_R2 ; Store the value of R2 for backup
ST R7, BACKUP_R7 ; Store the value of R7 for backup (return address)

NOT R2, R5 ; Perform bitwise NOT operation on R5 (MAX)
ADD R2, R2, #1 ; Increment R2 by 1

ADD R2, R6, R2 ; Add R6 (TOS) and R2 to R2
BRzp OVERFLOW_ERROR ; If R2 is zero or positive, jump to OVERFLOW_ERROR

ADD R6, R6, #1 ; Increment R6 (TOS) by 1
STR R0, R6, #0 ; Store R0 (value to push) into the memory at address R6

LD R2, BACKUP_R2 ; Load the backup value of R2
LD R7, BACKUP_R7 ; Load the backup value of R7 (return address)

RET ; Return from the subroutine

; Overflow error handling
OVERFLOW_ERROR
ST R0, R0_ERROR ; Store the value of R0 for error handling
LEA R0, OVERFLOW_MESSAGE; Load the effective address of OVERFLOW_MESSAGE into R0
PUTS ; Print the string stored at the address in R0 (OVERFLOW_MESSAGE)

LD R0, R0_ERROR ; Load the error value stored in R0_ERROR back into R0
LD R2, BACKUP_R2 ; Load the backup value of R2
LD R7, BACKUP_R7 ; Load the backup value of R7 (return address)

RET ; Return from the subroutine

; Data section for SUB_STACK_PUSH subroutine
HALT
OVERFLOW_MESSAGE .STRINGZ "Error Overflow!!\n" ; Store the overflow error message string
BACKUP_R2 .BLKW #1 ; Reserve one word for storing the backup value of R2
BACKUP_R7 .BLKW #1 ; Reserve one word for storing the backup value of R7 (return address)
R0_ERROR .BLKW #1 ; Reserve one word for storing the error value of R0
.END