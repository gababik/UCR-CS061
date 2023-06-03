;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Program 5 
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000

; Initialize the stack pointer (R6) with the address of the stack
ld r6, stack_addr

; Load the address of the main subroutine into R5 and jump to it
lea r5, main
jsrr r5

; The main subroutine
main
    ; Load the address of the input buffer into R1
    LEA R1, input

    ; Decrement the stack pointer
    LD R6, stack_addr
    ADD R6, R6, #-1

    ; Call the getter subroutine to get a string from the user
    ; The address of the prompt string is loaded into R2
    LD R4, getter
    LEA R2, prompter
    JSRR R4

    ; Call the stringlengthaddy subroutine to find the size of the input string
    LD R4, stringlengthaddy
    JSRR R4

    ; Call the palindromeaddy subroutine to check if the input string is a palindrome
    ; The end address of the string is calculated and loaded into R2
    ADD R2, R2, R1
    ADD R2, R2, #-1
    LD R4, palindromeaddy
    JSRR R4

    ; Print the result to the screen
    ; The address of the result string is loaded into R0
    LEA R0, results
    PUTS

    ; Check if the string is a palindrome and branch accordingly
    AND R0, R0, #0
    ADD R0, R3, R0
    BRz ispali

    ; If the string is not a palindrome, print the corresponding message
    PRINT_IS_NOT_PALI
        LEA R0, notstring
        PUTS
    
    ; If the string is a palindrome, print the corresponding message
    ispali
        LEA R0, finalone
        PUTS

    ; Halt the program
    halt

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------
; The address of the stack
stack_addr           .FILL    xFE00

; The addresses of the getter, stringlengthaddy, and palindromeaddy subroutines
getter .FILL    x3200
stringlengthaddy          .FILL    x3300
palindromeaddy      .FILL	  x3400

; The strings used in the program
prompter          .STRINGZ "Enter a string: "
results        .STRINGZ "\nThe string is "
notstring           .STRINGZ "not "
finalone         .STRINGZ	"a palindrome\n"

; The buffer for the user input string
input          .BLKW	  100

.end

;-----------------------------------------------------------------------------
; Subroutine: getstring - Gets a user string
;
; Parameter: R1 - The start address of where the string should be stored
; R2 - User prompt screen address
; R6 - Stack address
;
; Returns: None
;-----------------------------------------------------------------------------

.ORIG x3200
gettinginput
    STR R7, R6, #0 
    ADD R6, R6, #-1
    STR R5, R6, #0 
    ADD R6, R6, #-1
    STR R4, R6, #0 
    ADD R6, R6, #-1
    STR R1, R6, #0
    ADD R6, R6, #-1
    STR R0, R6, #0
    ADD R6, R6, #-1
    
    LD R5, temp
        NOT R5, R5
        ADD R5, R5, #1
        
outputprompt
    AND R0, R0, #0
    ADD R0, R2, R0
    PUTS
    
loop1
    GETC
    ADD R4, R5, R0
    BRZ is_done
    OUT
    STR R0, R1, #0
    ADD R1, R1, #1
    BR loop1
    
is_done
    STR R4, R1, #0
    
    ADD R6, R6, #1
    LDR R0, R6, #0 
    ADD R6, R6, #1
    LDR R1, R6, #0 
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0

RET
temp .fill xA;

.END


;-----------------------------------------------------------------------------
; Subroutine: stringlength - Compute the length of a zero-terminated string
;
; Parameter: R1 - The address of a zero-terminated string
; R6 - Stack address
;
; Returns: R2 - The length of the string
;-----------------------------------------------------------------------------
.ORIG x3300
stringlength
    STR R7, R6, #0 
    ADD R6, R6, #-1
    STR R3, R6, #0 
    ADD R6, R6, #-1
    STR R1, R6, #0 
    ADD R6, R6, #-1
    
    AND R2, R2, #0
    
loop2
    LDR R3, R1, #0
    BRZ ender
    ADD R2, R2, #1
    ADD R1, R1, #1
    BR loop2
    
ender
    ADD R6, R6, #1
    LDR R1, R6, #0 
    ADD R6, R6, #1
    LDR R3, R6, #0 
    ADD R6, R6, #1
    LDR R7, R6, #0 
RET

.END
;-----------------------------------------------------------------------------
; Subroutine: is_palindrome - Determines if a string is a palindrome
;
; Parameter: R1 - Beginning address of a zero-terminated string
; R2 - Ending address of a zero-terminated string
; R6 - Stack address
;
; Returns: R3 - 0 if the string is a palindrome, 1 if the string is not a palindrome
;-----------------------------------------------------------------------------
.ORIG x3400
palindrome
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0
    ADD R6, R6, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    
    NOT R4, R2
    ADD R4, R4, #1
    ADD R5, R4, R1
    BRZP center
    
    LDR R4, R1, #0
    NOT R4, R4
    ADD R4, R4, #1
    LDR R5, R2, #0
    
    ADD R5, R4, R5
    BRZ equal
    BR fail
    
    
    
center
    AND R3, R3, #0
    BR finish
    
equal
    ADD R1, R1, #1
    ADD R2, R2, #-1
    JSR palindrome
    BR finish
    
fail
    AND R3, R3, #0
    ADD R3, R3, #1
    BR finish
    
finish
    ADD R6, R6, #1
    LDR R4, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1
    LDR R7, R6, #0
    
    RET

.END