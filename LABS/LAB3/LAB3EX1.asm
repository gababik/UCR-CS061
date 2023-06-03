;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 3 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

;Start of code
.ORIG x3000
;load ;The Indirect memory addressing mode uses a label (aliased memory location) as a pointer.
;The Relative memory addressing mode uses a register containing a memory address as a pointer.
LD  R5, DATA_PTR ; the values of the pointers
ADD R6, R5, #1

LDR R3, R5, #0        ;Load the R5 values into R3, with 0 offset
LDR R4, R6, #0        ;Load the R6 values into R4, with 0 offset

ADD R3, R3, #1        ;increment
ADD R4, R4, #1        ;increment
    
STR R3, R5, #0        ;Stores values from R3 into where R5 points to
STR R4, R6, #0        ;Stores values from R4 into where R6 points to

;data
;POINTERS
HALT
DATA_PTR      .FILL x4000

.END

.ORIG x4000
DEC_65      .FILL #65
HEX_41      .FILL x41

.END