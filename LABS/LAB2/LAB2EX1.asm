;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 2 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================

;Start of code
.ORIG x3000
;load
LD R3, DEC_65 ;EVEN THOUGH THEY ARE DIFFERENT THEY BOTH PUT 65 INTO THE REGISTER
LD R4, HEX_41
;data
DEC_65      .FILL #65
HEX_41      .FILL x41
    
.END
