;=========================================================================
; Name & Email George Babik & gbabi001@ucr.edu
; Name: George Babik    
; Email: gbabi001@ucr.edu
; 
; Assignment name: Lab 3 EX 4
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000 
LEA R0, start
PUTS

LEA, R1, ARRAY_CALL

ARRAY_CALL .BLKW    #100
    ADD, R4, R4 #0
DO_WHILE
    ADD R4, R4, #1; adding loop number
    LEA R0, prompt ;prompt
    PUTS
    GETC                    ;Get user input and print it
    
    ADD R3, R0, #0 ;checking before contuning
    ADD R3, R3, #-10 ;Check if entered value is a decima
    ADD R3, R3, #-10 ;Check if entered value is a decimal
    ADD R3, R3, #-10 ;Check if entered value is a decimal
    ADD R3, R3, #-10 ;Check if entered value is a decimal
    ADD R3, R3, #-10 ;Check if entered value is a decimal
    ADD R3, R3, #-8 ;Check if entered value is a decimal
    Brp END_DO_WHILE ; what ever it number it is it subtracts 58 if 0 then its 48 - 58 is neg if 9 then 57 - 58 is negative
    OUT
    STR R0, R1, #0 ;Store user input at address in R2
    LEA R0, newline ;print newline
    PUTS
    ADD R1, R1, #1  
    ADD R3, R3, #0
    Brn DO_WHILE
END_DO_WHILE
LEA, R1, ARRAY_CALL
LEA R0, prompt3 ; prints out prompt 3
PUTS
LEA R0, prompt2
PUTS
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
start  .STRINGZ "Enter Number Or Hit Any Letter To End \n"
prompt2  .STRINGZ "Printing List \n"
prompt3 .STRINGZ "Ending Input: \n"
prompt .STRINGZ "Enter Any Number To Add List: \n"
.END