;=================================================
; George Babik: 
; gbabi001@ucr.edu:
; 
; Lab: lab 1, ex 1
; Lab section: 
; TA: 
; 
;=================================================
.ORIG x3000 
LD R1, DEC_0 ;Assigns R1 to #0
LD R2, DEC_12 ;Assigns R2 to #12
LD R3, DEC_6 ;Assigns R3 to #6

DO_WHILE
    ADD R1,R1,R2 ; R1 = R1 + R2
    ADD R3,R3, #-1 ; R3 = R3 - #1
    BRp DO_WHILE ; If R3>0 then it has to repeat, R3 holds the multiplier - we will use it as a loop counter
END_DO_WHILE

HALT ;LIKE EXIT IN C++

;DATA

DEC_0   .FILL   #0
DEC_12   .FILL   #12
DEC_6   .FILL   #6
    
.end
