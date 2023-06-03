;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 4 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
; =======================================================
; Main
; 	Test harness for SUB_FILL_ARRAY_
; =======================================================
.ORIG x3000

LD R5, SUB_FILL_ARRAY_3200
JSRR R5

;data
SUB_FILL_ARRAY_3200	.FILL	x3200

HALT
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_.ORIG x3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3200
LEA R1, ARRAY_1; creates array
AND R2, R2, #0 ; creates zero
ADD R3, R3, #-10 ; creates the counter
loop
	STR R2, R1, #0 ; stores r2 value to r1;
	ADD R1, R1, #1 ;adds one to r1 to move up list
	ADD R2, R2, #1; adds one to r2 to add another value
	ADD R3, R3, #1 ;counts up
	BRn loop ; when postive it ends
LEA R1, ARRAY_1

HALT
;data
ARRAY_1     .BLKW #10 ;at x3200
.END
