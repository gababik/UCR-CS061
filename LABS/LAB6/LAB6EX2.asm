;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 6 EX 2
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.Orig x3000

; Load NEWLINE constant into R2
LD R2, NEWLINE

; Calculate the Two's complement of R2 and store it in R2
NOT R2, R2
ADD R2, R2, #1

; Load BASE, MAX, and TOS addresses into R4, R5, and R6 respectively
LD R4, BASE
LD R5, MAX
LD R6, TOS

; Main loop for the program
WHILE_LOOP
; Prompt the user for input to pop or push
LEA R0, PROMPT_1
PUTS

; Read a character from the keyboard
GETC
; Display the character
OUT

; Load the OFFSET constant into R1 and add it to R0
LD R1, OFFSET
ADD R3, R0, R1

; If the input is zero, call the POP_STACK subroutine
BRz POP_STACK

; Prompt the user for a value to push
LEA R0, PROMPT_2
PUTS

; Read a character from the keyboard
GETC
; Display the character
OUT

; Add the Two's complement of R2 to R0
ADD R3, R0, R2
; If the result is zero, go to the end of the loop
BRz END_LOOP

; Store the user's input and load the NEWLINE constant into R0
ST R0, USER_INPUT
LD R0, NEWLINE

; Display the newline character
OUT
; Load the user's input and the OFFSET constant into R0 and R1 respectively
LD R0, USER_INPUT
LD R1, OFFSET

; Add R0 and R1 together, then load the address of the SUB_STACK_PUSH subroutine into R1
ADD R0, R0, R1
LD R1, SUB_STACK_PUSH

; Call the SUB_STACK_PUSH subroutine
JSRR R1

; Continue the main loop
BRnzp WHILE_LOOP

; Subroutine for popping values from the stack
POP_STACK
; Load the NEWLINE constant into R0 and display it
LD R0, NEWLINE
OUT

; Clear R0 and load the address of the SUB_STACK_POP subroutine into R1
AND R0, R0, #0
LD R1, SUB_STACK_POP

; Call the SUB_STACK_POP subroutine
JSRR R1

; Load the OFFSET constant into R1 and calculate its Two's complement
LD R1, OFFSET
NOT R1, R1
ADD R1, R1, #1

; Add R0 and R1 together
ADD R0, R0, R1

; If the result is negative, continue the main loop
BRn WHILE_LOOP

; Otherwise, calculate the Two's complement of R1 and add it to R2
NOT R1, R0
ADD R1, R1, #1
LD R2, NUM_MAX
ADD R2, R2, R1

; If the result is negative, continue the main loop
BRn WHILE_LOOP

; Display the popped value
OUT
; Display the message indicating the value was popped
LEA R0, PROMPT_3
PUTS

; Continue the main loop
BRnzp WHILE_LOOP

; End the program loop
END_LOOP
; Halt the program execution
HALT

; Define constants and memory locations for data and prompts
HALT
SUB_STACK_PUSH .FILL x3200
SUB_STACK_POP .FILL x3400
OFFSET .FILL #-48
NUM_MAX .FILL x39
NEWLINE .FILL x0A
BASE .FILL xA000
MAX .FILL xA005
TOS .FILL xA000

PROMPT_1 .STRINGZ "Pop (0) or Push (1)\n"
PROMPT_2 .STRINGZ "\nWhat value would you like to push?\n"
PROMPT_3 .STRINGZ " was the value popped\n"

USER_INPUT .BLKW #1
.END

;==========================================================================================
;Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
; If the stack was already full (TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R6 updated TOS
;==========================================================================================
.Orig x3200

; Save R2 and R7 values
ST R2, BACKUP_R2
ST R7, BACKUP_R7

; Check if the stack is full
NOT R2, R5
ADD R2, R2, #1

ADD R2, R6, R2
BRzp OVERFLOW_ERROR

; Push the value onto the stack
ADD R6, R6, #1
STR R0, R6, #0

; Restore R2 and R7 values
LD R2, BACKUP_R2
LD R7, BACKUP_R7

; Return from the subroutine
RET

; Handle overflow error
OVERFLOW_ERROR
; Save R0 value
ST R0, R0_ERROR

; Display overflow error message
LEA R0, OVERFLOW_MESSAGE
PUTS

; Restore R0, R2, and R7 values
LD R0, R0_ERROR
LD R2, BACKUP_R2
LD R7, BACKUP_R7

; Return from the subroutine
RET

; Data section for SUB_STACK_PUSH subroutine
HALT
OVERFLOW_MESSAGE .STRINGZ "Error Overflow!!\n"
R0_ERROR .BLKW #1
BACKUP_R2 .BLKW #1
BACKUP_R7 .BLKW #1
.END

;==========================================================================================
;Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If the stack was already empty (TOS = BASE), the subroutine has printed
; an underflow error message and terminated.
; Return Value: R0 value popped off of the stack
; R6 updated TOS
;==========================================================================================
.Orig x3400

; Save R2 and R7 values
ST R2, BACKUP_R2_2
ST R7, BACKUP_R7_2

; Check if the stack is empty
NOT R2, R4
ADD R2, R2, #1

ADD R2, R6, R2
BRnz ERROR

; Pop the value from the stack
LDR R0, R6, #0
ADD R6, R6, #-1

; Restore R2 and R7 values
LD R2, BACKUP_R2_2
LD R7, BACKUP_R7_2

; Return from the subroutine
RET

; Handle underflow error
ERROR
; Display underflow error message
LEA R0, UNDERFLOW_MESSAGE
PUTS

; Restore R2 and R7 values
LD R2, BACKUP_R2_2
LD R7, BACKUP_R7_2

; Return from the subroutine
RET
; Data section for SUB_STACK_POP subroutine
HALT
UNDERFLOW_MESSAGE .STRINGZ "Error Underflow!!\n"
BACKUP_R2_2 .BLKW #1
BACKUP_R7_2 .BLKW #1
.END

