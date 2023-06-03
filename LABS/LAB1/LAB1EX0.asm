;=================================================
; George Babik: 
; gbabi001@ucr.edu:
; 
; Lab: lab 1, ex 0
; Lab section: 
; TA: 
; 
;=================================================
.ORIG x3000 ; You need this to start every program its like main() for c++
LEA R0, MSG_PRINT ;This points to the address of the label MSG_PRINT which hold the address of what to print
PUTS ;This is the print statement that prints the above statement
HALT ;This ends the program
;data
    MSG_PRINT   .STRINGZ     "Hello World!" ;This is the text that holds is held by MSG_PRINT
    
.END ;like the return 0 in c++
