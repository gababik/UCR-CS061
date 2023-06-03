;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Program 1
; Lab section: 023
; TA: Montano, Westin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;------------------------------------------
;REG VALUES  R0  R1  R2  R3  R4  R5  R7  R7
;------------------------------------------
;PRE-LOOP     0   6   12   0   0   0   0   0
;Iteration01  0   5   12   12   0   0   0   0
;Iteration02  0   4   12   24   0   0   0   0
;Iteration03  0   3   12   36   0   0   0   0
;Iteration04  0   2   12   48   0   0   0   0
;Iteration05  0   1   12   60   0   0   0   0
;Iteration06  0   0   12   72   0   0   0   0
;-----------------------------------------
;


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R1, DEC_6    ;R1 = 6
LD R2, DEC_12   ;R2 = 12
AND R3, R3, #0  ;R3 = 0

DO_WHILE    
ADD R3, R3, R2  ;R3 += R2
ADD R1, R1, #-1 ;R1 -= 1;
BRp DO_WHILE    ;if LMR > 0 do while

HALT    ;"ends" program
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_0   .FILL   #0
DEC_6   .FILL   #6
DEC_12   .FILL   #12




;---------------	
;END of PROGRAM
;---------------	
.END


;-------------------
; PURPOSE of PROGRAM
;-------------------
; The purpose of this program is to perform a simple multiplication operation.
; It multiplies the number 12 by 6 using a looping mechanism, storing the result
; in register R3. The multiplication is implemented as a repeated addition in a
; loop that iterates 6 times.
; The program uses 3 registers: R1, R2, and R3. R1 is used as a counter for the
; loop and is initially loaded with the value 6. R2 is loaded with the value 12,
; the number to be repeatedly added. R3 is used to accumulate the sum, acting as
; the result of the multiplication.
; The program ends with a HALT instruction.
; There is no input or output functionality, and the result remains stored in R3.
; Therefore, to observe the result of the multiplication, one needs to examine
; the state of the machine after the program has run.
; There is no error checking or input validation as the program doesn't accept user input.
;-------------------