;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik
; Email: gbabi001@ucr.edu
;
; Assignment name: Program 2
; Lab section: 023
; TA: Montano, Westin
;
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
.ORIG x3000; STARTS
LEA R0, intro; 
PUTS

;NUM 1
  GETC
  OUT
  ADD R1, R0, #0
;NEWLINE
  LEA R0, newline
  PUTS
;NUM2
  GETC
  OUT
  ADD R2, R0, #0
;NEWLINE
  LEA R0, newline
  PUTS
;OUT PUT FIRST NUM
  ADD R0, R1, #0
  OUT
;OUT PUT MINUS
  LEA R0, minus
  PUTS
;OUT PUT SECOND NUM
  ADD R0, R2, #0
  OUT
;OUT PUT EQUAL
  LEA R0, equal
  PUTS
;two compliment
  NOT R3, R2
  ADD R3, R3, #1
;adds the producs together
  ADD R3, R3, R1
  BRn is_neg ;checks to see if neg if neg sends to is_neg
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #3 ; converts to binary
  ADD R0, R3, #0 ;pushes to R0
  OUT
  LEA R0, NEWLINE
  PUTS
  
  HALT
  
  is_neg
  NOT R3, R3
  ADD R3, R3, #1
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #15 ; converts to binary
  Add R3, R3, #3 ; converts to binary
  ;OUT PUT MINUS
  LEA R0, neg
  PUTS
  
  ADD R0, R3, #0 ;pushes to R0
  OUT
  LEA R0, NEWLINE
  PUTS

  
  HALT

;------
;Data
;------

intro .STRINGZ "ENTER two numbers (i.e '0'....'9')\n" 
newline .STRINGZ "\n"; String that holds the newline character
equal .STRINGZ " = "
minus .STRINGZ " - "
neg .STRINGZ "-"
newValue 

;---------------
;END of PROGRAM
;---------------
.END


;-------------------
; PURPOSE of PROGRAM
;-------------------
; This program is designed to take in two single-digit ASCII numeric inputs from the user,
; perform a subtraction operation on them, and display the result as an ASCII character.
;
; The program begins by displaying an introductory message to the user, asking them to input
; two numbers. It then captures the first digit, outputs it for the user to see, and stores it
; in register R1. It does the same for the second digit, storing it in register R2. It then
; prints out the initial subtraction expression to the user.
;
; Following that, the program calculates the two's complement of the second number and adds
; it to the first number to perform the subtraction. It then checks if the result is negative.
; If the result is not negative, it converts the number to its corresponding ASCII value and
; outputs the result to the console.
;
; If the result is negative, it adjusts the negative result to its positive equivalent,
; converts this to its corresponding ASCII value, and outputs a negative sign followed by
; the result to the console.
;
; Both branches end with a newline being outputted to separate the result from any subsequent
; console output, and a HALT instruction to stop the program.
;
; Note that the program assumes valid input (i.e., ASCII values of digits 0-9) and does not
; handle errors associated with invalid input or overflows from the subtraction.
;-------------------