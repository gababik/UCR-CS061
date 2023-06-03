
;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Program 3
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

.ORIG x3000

; Load the address of the Convert subroutine into R6
LD R6, pointer
; Load the value at the memory address stored in R6 (the Convert subroutine) into R1
LDR R1, R6, #0

; Load the value 16 (the number of digits to convert) into R2
LD R2, numCount
; Load the value 4 (the number of spaces to print before each digit) into R3
LD R3, numCount2

; Start of the for loop
loop
  ; Set R3 to 0 and branch to SPACES if it is positive
  ADD R3, R3, #0
  BRp next
    ; If R3 is negative, print a space and reset R3 to 4
    LEA R0, space
    PUTS
    LD R3, numCount2
    ADD R2, R2, #0
    BR endSpace
  ; If R3 is positive, print the current digit
  next
    ; If R1 is negative, print 0
    ADD R1, R1, #0
    BRn IF
    LEA R0, numZero
    PUTS
    BR ends
    ; If R1 is positive, print 1
    IF
    LEA R0, numOne
    PUTS
    BR ends
    ; Multiply R1 by 2 and decrement R3 and R2
    ends
    ADD R1, R1, R1
    ADD R3, R3, #-1
    ADD R2, R2, #-1
    BR endSpace
  ; End of the if/else statement
  endSpace
    ; Branch back to the start of the for loop if R3 is positive
    BRp loop

; Print a newline character at the end of the program
LEA R0, newline
PUTS

; Halt the program
HALT

; Define constant values and strings used in the program
numCount .FILL #16
numCount2 .FILL #4
numOne .STRINGZ "1"
numZero .STRINGZ "0"
space .STRINGZ " "
newline .STRINGZ "\n"
pointer .FILL xCA01

; Define the Convert subroutine
.END
.ORIG xCA01
Convert .FILL xABCD
.END
;-------------------
; PURPOSE of PROGRAM
;-------------------
; The purpose of this program is to convert a 16-bit binary number into a string
; of ASCII characters and print that string to the console, with each digit preceded
; by a certain number of spaces.

; The binary number to convert is stored in a subroutine located at memory address xCA01.
; The address of this subroutine is loaded into R6, and the binary number is loaded into R1.

; The program has two counters, one for the number of binary digits to convert (R2),
; which is set to 16, and one for the number of spaces to print before each digit (R3),
; which is set to 4.

; The program then enters a loop. In each iteration of the loop, it first checks if R3 is
; positive. If R3 is negative, it prints a space and resets R3 to 4. If R3 is positive, it
; checks if R1 is negative. If R1 is negative, it prints a 0 and goes to the end of the loop.
; If R1 is positive, it prints a 1 and goes to the end of the loop.

; At the end of the loop, it multiplies R1 by 2 (shifting the binary number one place to
; the left), decrements R3 and R2, and goes back to the start of the loop if R2 is positive.

; Finally, after exiting the loop, it prints a newline character and halts the program.

; The program makes use of a few defined constants and strings for the number of digits to
; convert, the number of spaces to print, the ASCII characters for 0 and 1, a space, and a
; newline character.

; Note that the program assumes the binary number to convert is valid and does not check
; for any errors.
;-------------------