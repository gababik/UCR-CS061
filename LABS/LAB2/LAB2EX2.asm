;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 2 EX 2
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

;Start of code
.ORIG x3000
;load
LDI R3, DEC_65_PTR ;EVEN THOUGH THEY ARE DIFFERENT THEY BOTH PUT 65 INTO THE REGISTER
LDI R4, HEX_41_PTR

;code to increment the values in R3 and R4 by 1.
ADD R3, R3, #1
ADD R4, R4, #1
;STORE
STI R3, DEC_65_PTR ;
STI R4, HEX_41_PTR
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