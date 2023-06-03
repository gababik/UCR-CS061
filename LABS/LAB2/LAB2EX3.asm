;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 2 EX 3
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

;Start of code
.ORIG x3000
;load ;The Indirect memory addressing mode uses a label (aliased memory location) as a pointer.
;The Relative memory addressing mode uses a register containing a memory address as a pointer.
LD  R5, DEC_65_PTR ; the values of the pointers
LD  R6, HEX_41_PTR 

LDR R3, R5, #0 ;EVEN THOUGH THEY ARE DIFFERENT THEY BOTH PUT 65 INTO THE REGISTER
LDR R4, R6, #0
;; values of the pointers
;code to increment the values in R3 and R4 by 1.
ADD R3, R3, #1
ADD R4, R4, #1
;STORE
STR R3, R5, #0;
STR R4, R6, #0

;data
;POINTERS
HALT
DEC_65_PTR      .FILL x4000
HEX_41_PTR      .FILL x4001

.END

.ORIG x4000
DEC_65      .FILL #65
HEX_41      .FILL x41

.END