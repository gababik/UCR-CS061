;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 3 EX 2
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000 


LEA, R1, ARRAY_CALL

ARRAY_CALL .BLKW    #10

ADD R3, R3, #10    


DO_WHILE
    LEA R0, prompt
    PUTS
    GETC                    ;Get user input and print it
    OUT
    STR R0, R1, #0            ;Store user input at address in R2
    LEA R0, newline            ;print newline
    PUTS
    ADD R1, R1, #1    
    ADD R3, R3, #-1
    BRp DO_WHILE
END_DO_WHILE


HALT
newline .STRINGZ "\n"
prompt  .STRINGZ "Enter number \n"
.END