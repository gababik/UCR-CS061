;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 4 EX 4
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
; =======================================================
; Main
; 	Test harness for SUB_FILL_ARRAY_
; =======================================================
.ORIG x3000
LEA R1, ARRAY_1; creates array 3009
LD R5, SUB_FILL_ARRAY_3200
JSRR R5
LEA R1, ARRAY_1; resets array
LD R5, SUB_CHANGE_ARRAY_3400
JSRR R5
LEA R1, ARRAY_1; resets array
LD R5, SUB_OUT_ARRAY_3600
JSRR R5
LEA R1, ARRAY_1; resets array
LD R5, SUB_POUT_ARRAY_3800
JSRR R5
LEA R1, ARRAY_1; resets array
;data
HALT
SUB_FILL_ARRAY_3200	.FILL	x3200
SUB_CHANGE_ARRAY_3400	.FILL	x3400
SUB_OUT_ARRAY_3600	.FILL	x3600
SUB_POUT_ARRAY_3800	.FILL	x3800
ARRAY_1     .BLKW #10 
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_.ORIG x3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3200
AND R2, R2, #0 ; creates zero
ADD R3, R3, #-10 ; creates the counter
loop
	STR R2, R1, #0 ; stores r2 value to r1;
	ADD R1, R1, #1 ;adds one to r1 to move up list
	ADD R2, R2, #1; adds one to r2 to add another value
	ADD R3, R3, #1 ;counts up
	BRn loop ; when postive it ends

RET
;data

;at x3200
.END
;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3400

ADD R3, R3, #-10 ; creates the counter
loop2
    LDR R2, R1, #0 ;LOADS r1 to r2
    ADD R2, R2, #15 ; adding 
    ADD R2, R2, #15 ; adding
    ADD R2, R2, #15 ; adding
    ADD R2, R2, #3 ; now it is 48 greater which turns zero decimal to 48 decimal which is ascii zero
    STR R2, R1, #0 ; stores r2 value to r1;
	ADD R1, R1, #1 ;adds one to r1 to move up list
	ADD R3, R3, #1 ;counts up
	BRn loop2 ; when postive it ends

RET
.END
;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3600
ADD R3, R3, #-10 ; creates the counter
loop3
    LDR R0, R1, #0 ;LOADS r1 to r2
    OUT
    LEA R0, newline
    PUTS
	ADD R1, R1, #1 ;adds one to r1 to move up list
	ADD R3, R3, #1 ;counts up
	BRn loop3 ; when postive it ends

RET
;data
HALT
newline .STRINGZ "\n"
.END
;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3800
LEA R0, SIGN
PUTS
LD R5, SUB_2POUT_ARRAY_3800
JSRR R5
LEA R0, SIGN
PUTS
ret
;data
SUB_2POUT_ARRAY_3800	.FILL	x3800
SIGN .STRINGZ "====="
.END
