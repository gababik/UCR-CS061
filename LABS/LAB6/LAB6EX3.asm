;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 6 EX 3
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
; The program starts execution at memory address x3000.
.orig x3000

; Load the addresses of several predefined values into registers R4, R5, R6, and R1.
LD R4, BASE     ; Load the address of 'BASE' into R4
LD R5, MAX      ; Load the address of 'MAX' into R5
LD R6, TOS      ; Load the address of 'TOS' into R6
LD R1, PUSH     ; Load the address of 'PUSH' into R1

; Display the 'PROMPT' message to the user.
LEA R0, PROMPT  ; Load the address of 'PROMPT' into R0
PUTS            ; Output the string pointed to by R0

; Get the first character from the user and output it.
GETC            ; Get a character from the keyboard, store it in R0
OUT             ; Output the character in R0

; Add the value at 'OFFSET' to the character and call the subroutine at 'PUSH'.
LD R2, OFFSET   ; Load the value of 'OFFSET' into R2
ADD R0, R0, R2  ; Add 'OFFSET' to the character, store the result in R0
JSRR R1         ; Jump to the subroutine at 'PUSH' and save the return address in R1
GETC            ; Get another character from the keyboard, store it in R0
OUT             ; Output the character in R0

; Repeat the above process for the second character.
ADD R0, R0, R2 
JSRR R1
GETC
OUT

; Output a newline character.
LD R0, NEWLINE  ; Load the address of 'NEWLINE' into R0
OUT             ; Output the newline character

; Call the subroutine at 'ADD_1'.
LD R1, ADD_1    ; Load the address of 'ADD_1' into R1
JSRR R1         ; Jump to the subroutine at 'ADD_1' and save the return address in R1

; Call the subroutine at 'POP'.
LD R1, POP      ; Load the address of 'POP' into R1
JSRR R1         ; Jump to the subroutine at 'POP' and save the return address in R1

; If R0 is positive, go to 'ADDI'.
LD R3, MAX_DIG  ; Load the value of 'MAX_DIG' into R3
ADD R3, R3, R0  ; Add R0 to 'MAX_DIG', store the result in R3
BRp ADDI        ; If the result is positive, branch to 'ADDI'

; Invert R2, add 1, add R0, and output the result.
NOT R2, R2      ; Invert all bits of R2
ADD R2, R2, #1  ; Add 1 to R2
ADD R0, R0, R2  ; Add R0 to R2, store the result in R0
OUT             ; Output the result

; Display the 'MESSAGE' to the user.
LEA R0, MESSAGE ; Load the address of 'MESSAGE' into R0
PUTS            ; Output the string pointed to by R0

; Halt the program.
HALT

; If 'BRp ADDI' is called, call the subroutine at 'DECI', display the 'MESSAGE', and halt the program.
ADDI
  LD R1, DECI            ; Load the address of 'DECI' into R1
  JSRR R1         ; Jump to the subroutine at 'DECI' and save the return address in R1

  LEA R0, MESSAGE ; Load the address of 'MESSAGE' into R0
  PUTS            ; Output the string pointed to by R0

  HALT            ; Halt the program

; Local Data
; Each label is a memory location that holds a specific value or address.
HALT
PUSH .FILL x3200     ; Fill the memory location labeled 'PUSH' with the value x3200
POP .FILL x3400      ; Fill the memory location labeled 'POP' with the value x3400
ADD_1 .FILL x3600    ; Fill the memory location labeled 'ADD_1' with the value x3600
DECI .FILL x4000     ; Fill the memory location labeled 'DECI' with the value x4000
OFFSET .FILL #-48    ; Fill the memory location labeled 'OFFSET' with the value -48
MAX_DIG .FILL #-9    ; Fill the memory location labeled 'MAX_DIG' with the value -9
NEWLINE .FILL x0A    ; Fill the memory location labeled 'NEWLINE' with the value x0A
BASE .FILL xA000     ; Fill the memory location labeled 'BASE' with the value xA000
MAX .FILL xA005      ; Fill the memory location labeled 'MAX' with the value xA005
TOS .FILL xA000      ; Fill the memory location labeled 'TOS' with the value xA000

; String literals
PROMPT .STRINGZ "Enter two single digit numbers and the operation (no spaces)\n"
MESSAGE .STRINGZ " is the result.\n"

; End of the program.
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Description: This subroutine pushes a value onto the stack, ensuring no overflow occurs.
; Parameters:
; - R0: The value to push onto the stack
; - R4: BASE: A pointer to the base (one less than the lowest available address) of the stack
; - R5: MAX: The "highest" available address in the stack
; - R6: TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e., to address TOS+1).
; If the stack was already full (TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R6 - updated TOS
;------------------------------------------------------------------------------------------
.Orig x3200
ST R2, BACKUP_R2 ; Save R2 and R7 for restoration later
ST R7, BACKUP_R7
NOT R2, R5 ; Calculate the difference between TOS and MAX, check for overflow
ADD R2, R2, #1
ADD R2, R6, R2
BRzp ERROR ; Branch to ERROR if overflow occurs

ADD R6, R6, #1 ; Increment TOS and store the value in R0 at the new TOS
STR R0, R6, #0

LD R2, BACKUP_R2 ; Restore R2 and R7 to their original values
LD R7, BACKUP_R7
RET ; Return to caller

ERROR: ; Error handling for overflow
ST R0, R0_ERROR ; Save R0 for restoration later
LEA R0, OVERFLOW_MESSAGE
PUTS ; Print overflow error message

LD R0, R0_ERROR ; Restore R0 and return to caller
LD R2, BACKUP_R2
LD R7, BACKUP_R7
RET

; Data labels for SUB_STACK_PUSH
HALT
OVERFLOW_MESSAGE .STRINGZ "Error Overflow!!\n"
R0_ERROR .BLKW #1
BACKUP_R2 .BLKW #1
BACKUP_R7 .BLKW #1
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Description: This subroutine pops a value from the stack, ensuring no underflow occurs.
; Parameters:
; - R4: BASE: A pointer to the base (one less than the lowest available address) of the stack
; - R5: MAX: The "highest" available address in the stack
; - R6: TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If the stack was already empty (TOS = BASE), the subroutine has printed
; an underflow error message and terminated.
; Return Value: R0 - value popped off of the stack
; R6 - updated TOS
;------------------------------------------------------------------------------------------
.Orig x3400
ST R2, BACKUP_R2_2 ; Save R2 and R7 for restoration later
ST R7, BACKUP_R7_2
NOT R2, R4 ; Calculate the difference between TOS and BASE, check for underflow
ADD R2, R2, #1
ADD R2, R6, R2
BRnz ERROR_x3400 ; Branch to ERROR_x3400 if underflow occurs

LDR R0, R6, #0 ; Load the value at TOS into R0
ADD R6, R6, #-1 ; Decrement TOS

LD R2, BACKUP_R2_2 ; Restore R2 and R7 to their original values
LD R7, BACKUP_R7_2
RET ; Return to caller

ERROR_x3400: ; Error handling for underflow
LEA R0, UNDERFLOW_MESSAGE
PUTS ; Print underflow error message

LD R2, BACKUP_R2_2
LD R7, BACKUP_R7_2

RET

; Data labels for SUB_STACK_POP
HALT
UNDERFLOW_MESSAGE .STRINGZ "Error Underflow!!\n"
BACKUP_R2_2 .BLKW #1
BACKUP_R7_2 .BLKW #1
.END

;------------------------------------------------------------------------------------------
;Subroutine: ADD
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;  added them together, and pushed the resulting value back
;  onto the stack.
; Return Value: R6  updated top value
;------------------------------------------------------------------------------------------
.orig x3600

; Save registers R0, R1, R2, R3, and R7 for restoration later
ST R0, BACKUP_R0_3
ST R1, BACKUP_R1_3
ST R2, BACKUP_R2_3
ST R3, BACKUP_R3_3
ST R7, BACKUP_R7_3

; Pop the first value from the stack
LD R1, POP_2
JSRR R1

; Save the popped value
ST R0, ONE

; Pop the second value from the stack
JSRR R1

; Move the second popped value to R3 and load first popped value to R2
ADD R3, R0, #0
LD R2, ONE

; Call ADD subroutine to add the two popped values
LD R1, ADD_2
JSRR R1

; Push the result back onto the stack
LD R1, PUSH_2
JSRR R1

; Restore the original values of R0, R1, R2, R3, and R7
LD R0, BACKUP_R1_3
LD R1, BACKUP_R1_3
LD R2, BACKUP_R2_3
LD R3, BACKUP_R3_3
LD R7, BACKUP_R7_3

; Return to the caller
RET

;Subroutine Data
HALT
POP_2 .FILL x3400
ADD_2 .FILL x3800
PUSH_2 .FILL x3200

ONE .BLKW #1
BACKUP_R0_3 .BLKW #1
BACKUP_R1_3 .BLKW #1
BACKUP_R2_3 .BLKW #1
BACKUP_R3_3 .BLKW #1
BACKUP_R7_3 .BLKW #1
.END
;------------------------------------------------------------------------------------------
;Subroutine: SUB_ADD
; Parameter (R2): The first number to be added
; Parameter (R3): The second number to be added
; Postcondition: The subroutine adds the two numbers in R2 and R3 and returns their result
; Return Value: R0, addition result
;------------------------------------------------------------------------------------------
.orig x3800

; Save R7 for restoration later
ST R7, BACKUP_R7_38

; Clear R0
AND R0, R0, #0

; Add R2 and R3 and store the result in R0
ADD R0, R0, R2
ADD R0, R0, R3

; Restore the original value of R7
LD R7, BACKUP_R7_38

; Return to the caller
RET

;Subroutine Data
HALT
BACKUP_R7_38 .BLKW #1
.END

;------------------------------------------------------------------------------------------
;Subroutine: SUB_PRINT_DECIMAL
; Parameter (R0): The number to be printed
; Postcondition: The subroutine outputs a multi digit number stored in R0
; Return Value: None
;------------------------------------------------------------------------------------------
.orig x4000

; Save registers R1, R2, R3, and R7 for restoration later
ST R1, BACKUP_R1_4
ST R2, BACKUP_R2_4
ST R3, BACKUP_R3_4
ST R7, BACKUP_R7_4

; Load the ASCII offset for decimal digits to R3
LD R3, OFFSET_2

; Clear R1
AND R1, R1, #0

; Loop to divide the number by 10 until it is less than 10
TENS_LOOP
ADD R0, R0, #-10
BRn PRINT_NUM

ADD R1, R1, #1
BRnzp TENS_LOOP

; When the number is less than 10, print it
PRINT_NUM
ADD R2, R0, #0
ADD R0, R1, #0
; Move the remainder (R2) and the quotient (R0) to their respective registers
ADD R0, R0, R3
OUT

; Restore the original number and output the last digit
ADD R0, R2, #10
ADD R0, R0, R3
OUT

; Restore the original values of R1, R2, R3, and R7
LD R1, BACKUP_R1_4
LD R2, BACKUP_R2_4
LD R3, BACKUP_R3_4
LD R7, BACKUP_R7_4

; Return to the caller
RET

;Subroutine Data
HALT
OFFSET_2 .FILL #48 ; Offset for converting numbers to ASCII characters for output
BACKUP_R1_4 .BLKW #1 ; Backup for register R1
BACKUP_R2_4 .BLKW #1 ; Backup for register R2
BACKUP_R3_4 .BLKW #1 ; Backup for register R3
BACKUP_R7_4 .BLKW #1 ; Backup for register R7
.END
