;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 3 EX 3
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000 

LEA R0, prompt3
PUTS
LEA, R1, ARRAY_CALL

ARRAY_CALL .BLKW    #100

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

LEA, R1, ARRAY_CALL
LEA R0, prompt2
PUTS
ADD R4, R4, #10
LOOP
    LDR R0, R1, #0
    OUT
    LEA R0, newline            ;print newline
    PUTS
    ADD R1, R1, #1
    ADD R4, R4, #-1
    BRp LOOP
END_LOOP
HALT
newline .STRINGZ "\n"
prompt  .STRINGZ "Enter number \n"
prompt2  .STRINGZ "Printing Values \n"
prompt3  .STRINGZ "This is exercise 3 \n"
.END