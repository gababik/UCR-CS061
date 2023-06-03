;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 2 EX 4
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000
LD R0, HEX_61
LD R1, HEX_1A
DO_WHILE
    OUT
    ADD R0, R0, #1  ;adds
    ADD R1, R1, #-1 ;subs
    BRp DO_WHILE ;does it the length of the alphabet so 26 times
END_DO_WHILE

HALT
HEX_61  .FILL x61
HEX_1A  .FILL x1A
.END