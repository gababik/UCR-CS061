;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Program 4
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================
.ORIG x3000
; Set up the program starting at memory address x3000
GO_TOP         
; Initial setup of registers
ADD R4, R4, #0 ; Initialize R4 to 0
LD R1,COUNTER  ; Load the value in the memory location labeled COUNTER into R1
LD R2, TRACKER ; Load the value in the memory location labeled TRACKER into R2
; Print the prompt
LD R0, prompt ; Load the address of the prompt string into R0
PUTS ; Print the string

GETC ; Get a character from the keyboard

; Check if the first character is a newline
ADD R1, R0, #-10 ; Subtract 10 from the value in R0
BRz EMPTY_INPUT ; If the result is zero, branch to the EMPTY_INPUT label

BR TEST ; Otherwise, branch to the label TEST
STOP_TEST  ; Label for stopping the test

ADD R5, R0, #0 ; Move the value in R0 to R5

; Subtract 16 three times from the value in R0
ADD R0, R0, #-16     
ADD R0, R0, #-16
ADD R0, R0, #-13

BRz NEGATIVE ; Branch to the label NEGATIVE if the result is zero

ADD R0, R0, #2 ; Add 2 to the value in R0
BRz adding  ; Branch to the label adding if the result is zero


BR POSITIVIE ; Branch to the label POSITIVE

POSITIVIE ; Label for positive numbers
  LEA R0, RESTART ; Load the address of the memory location labeled RESTART into R0
  ADD R0, R5, #0 ; Move the value in R5 to R0
  OUT ; Output the value in R0 to the console

  ADD R4, R0, #0 ; Move the value in R0 to R4
; Subtract 16 three times from the value in R4
  ADD R4, R4, #-16 
  ADD R4, R4, #-16
  ADD R4, R4, #-16

  ADD R1, R1, #-1 ; Decrement the value in R1

  OUTPUT1 ; Label for output 1

  LOOP         ; Start of loop  
    GETC  ; Get a character from the keyboard
    OUT ; Output the value in R0 to the console

    BR TEST1 ; Branch to the label TEST1
    STOP_TEST1  ; Label for stopping test 1

    ADD R3, R0, #0     ; Move the value in R0 to R3
    ADD R3, R3, #-10  ; Subtract 10 from the value in R3
    BRz EXIT   ; Branch to the label EXIT if the result is zero

    ; Subtract 16 three times from the value in R0
    ADD R0, R0, #-16 
    ADD R0, R0, #-16
    ADD R0, R0, #-16

    ADD R6, R4, #0 ; Move the value in R4 to R6

    MULT            ; Label for multiplication
      ADD R4, R4, R6  ; Multiply the value in R4 by the value in R6
      ADD R2, R2, #-1 ; Decrement the value in R2
      BRp MULT ; Branch to the label MULT if the result is positive

    ADD R4, R4, R0 ; Add the value in R0 to the value in R4

    LD R2, TRACKER ; Load the value in the memory location labeled TRACKER into R2
    ADD R1, R1, #-1 ; Decrement the value in R1
    BRp LOOP  ; Branch to the label LOOP if the result is positive

    HALT  ; Halt the program

  EXIT ; Label for exit

  HALT  ; Halt the program

NEGATIVE  ; Label for negative numbers
  LEA R0, sign_neg  ; Load the address of the memory location labeled sign_neg into R0
  PUTS ; Print the string

  LOOP2 ; Start of loop 2
    GETC   ; Get a character from the keyboard
    OUT  ; Output the value in R0 to the console

    BR TEST2  ; Branch to the label TEST2
    STOP_TEST2 ; Label for stopping test 2

    ADD R3, R0, #0 ; Move the value in R0 to R3
    ADD R3, R3, #-10 ; Subtract 10 from the value in R3
    BRz EXIT2 ; Branch to the label EXIT2 if the result is zero

    ; Subtract 16 three times from the value in R0
    ADD R0, R0, #-16
    ADD R0, R0, #-16
    ADD R0, R0, #-16

    ADD R6, R4, #0   ; Move the value in R4 to R6



    MULT2  ; Label for multiplication 2
      ADD R4, R4, R6 ; Multiply the value in R4 by the value in R6
      ADD R2, R2, #-1 ; Decrement the value in R2
      BRp MULT2 ; Branch to the label MULT2 if the result is positive

    ADD R4, R4, R0 ; Add the value in R0 to the value in R4

    LD R2, TRACKER ; Load the value in the memory location labeled TRACKER into R2
    ADD R1, R1, #-1  ; Decrement the value in R1
    BRp LOOP2 ; Branch to the label LOOP2 if the result is positive

    NOT R4, R4 ; Reverse the bits of the value in R4
    ADD R4, R4, #1 ; Add 1 to the value in R4

    HALT ; Halt the program

  EXIT2  ; Label for exit 2

  NOT R4, R4 ; Reverse the bits of the value in R4
  ADD R4, R4, #1 ; Add 1 to the value in R4

  HALT ; Halt the program

adding ; Label for addition
  LEA R0, sign_pos ; Load the address of the memory location labeled sign_pos into R0
  PUTS ; Print the string 
  BR OUTPUT1 ; Branch to the label OUTPUT1

TEST ; Label for first input validation test
  ADD R7, R0, #0 ; Move the value in R0 to R7
  LD R6, TRACKER ; Load the value in the memory location labeled TRACKER into R6

 ; Add 48 (15 * 3 + 3) to the value in R6
  ADD R6, R6, #15
  ADD R6, R6, #15
  ADD R6, R6, #15
  ADD R6, R6, #3



  NOT R6, R6  ; Reverse the bits of the value in R6
  ADD R6, R6, #1  ; Add 1 to the value in R6

  ADD R6, R7, R6 ; Add the value in R7 to the value in R6
  BRp RETURN_ERROR ; Branch to the label RETURN_ERROR if the result is positive

  BR STOP_TEST ; Branch to the label STOP_TEST



TEST1     ; Label for second input validation test
  ADD R7, R0, #0  ; Move the value in R0 to R7
  LD R6, TRACKER ; Load the value in the memory location labeled TRACKER into R6

; Add 48 (15 * 3 + 3) to the value in R6
  ADD R6, R6, #15
  ADD R6, R6, #15
  ADD R6, R6, #15
  ADD R6, R6, #3

  NOT R6, R6 ; Reverse the bits of the value in R6
  ADD R6, R6, #1  ; Add 1 to the value in R6

  ADD R6, R7, R6 ; Add the value in R7 to the value in R6
  BRp RETURN_ERROR  ; Branch to the label RETURN_ERROR if the result is positive

  BR STOP_TEST1  ; Branch to the label STOP_TEST1



TEST2 ; Label for third input validation test
  ADD R7, R0, #0 ; Move the value in R0 to R7
  LD R6, TRACKER ; Load the value in the memory location labeled TRACKER into R6

 ; Add 48 (15 * 3 + 3) to the value in R6
  ADD R6, R6, #15 
  ADD R6, R6, #15
  ADD R6, R6, #15
  ADD R6, R6, #3

  NOT R6, R6 ; Reverse the bits of the value in R6
  ADD R6, R6, #1  ; Add 1 to the value in R6

  ADD R6, R7, R6 ; Add the value in R7 to the value in R6
  BRp RETURN_ERROR ; Branch to the label RETURN_ERROR if the result is positive

  BR STOP_TEST2 ; Branch to the label RETURN_ERROR if the result is positive


RETURN_ERROR ; Label for returning an error
  LEA R0, NLINE  ; Load the address of the NLINE string into R0
  PUTS ; Print the string
  LD R0, errorPrompt   ; Load the address of the errorPrompt string into R0
  PUTS   ; Print the string

  LEA R0, NLINE  ; Load the address of the NLINE string into R0
  PUTS ; Print the string
  AND R4, R4, #0
  BR GO_TOP   ; Branch to the label GO_TOP

EMPTY_INPUT ; This label handles the case of an empty input
AND R4, R4, #0
HALT

HALT ; Halt the program
sign_pos     .STRINGZ "+" ; Define the string "+"
sign_neg     .STRINGZ "-" ; Define the string "-"
NLINE .STRINGZ "\n"  ; Define the string for a new line
COUNTER   .FILL #5 ; Fill the memory location labeled COUNTER with the value 5
TRACKER  .FILL #9 ; Fill the memory location labeled TRACKER with the value 9
RESTART   .FILL #0 ; Fill the memory location labeled RESTART with the value 0

prompt .FILL xB000
errorPrompt .FILL xB200
.END

.ORIG xB000	 
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 
.STRINGZ	 "ERROR: invalid input\n"

.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
