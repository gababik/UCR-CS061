;=========================================================================
; Name & Email: George Babik & gbabi001@ucr.edu
; 
; Assignment name: Lab 8 EX 1
; Lab section: 023
; TA: Montano, Westin
; 
;=========================================================================
.ORIG x3000  ; Program starts at memory address x3000

	LD R6, SUB_FILL_REGISTER_PTR ; Load memory address of subroutine SUB_FILL_REGISTER_PTR into R6
	JSRR R6 ; Jump to subroutine, saving return address in R7

    ADD R1, R1, #1
    
	LD R6, SUB_PRINT_DECIMAL_PTR ; Load memory address of subroutine SUB_PRINT_DECIMAL_PTR into R6
	JSRR R6 ; Jump to subroutine, saving return address in R7
	
	HALT ; Stop the program
	
	SUB_FILL_REGISTER_PTR .FILL x3200 ; Memory location holding address of SUB_FILL_REGISTER_3200
	SUB_PRINT_DECIMAL_PTR .FILL x3400 ; Memory location holding address of SUB_PRINT_DECIMAL_3400

.END ; End of program

;=======================================================================
; Subroutine: SUB_FILL_REGISTER_3200
; Postcondition: Fill R1 with a hard-coded value in the subroutine data
; Return Value: (R1) The hard-coded value
;=======================================================================
.ORIG x3200  ; SUB_FILL_REGISTER_3200 subroutine begins here

	SUB_FILL_REGISTER_3200 ; Subroutine label

		; Save current values of all registers before subroutine operation
		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		LD R1, THE_VALUE_3200  ; Load hard-coded value into R1

		; Restore original values of all registers after subroutine operation
		LD R0, BACKUP_R0_3200
		LD R2, BACKUP_R2_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R5, BACKUP_R5_3200
		LD R6, BACKUP_R6_3200
		LD R7, BACKUP_R7_3200
		RET  ; Return from subroutine

	; Reserve memory for storing original values of registers R0 through R7
	BACKUP_R0_3200 .BLKW #1
	BACKUP_R1_3200 .BLKW #1
	BACKUP_R2_3200 .BLKW #1
	BACKUP_R3_3200 .BLKW #1
	BACKUP_R4_3200 .BLKW #1
	BACKUP_R5_3200 .BLKW #1
	BACKUP_R6_3200 .BLKW #1
	BACKUP_R7_3200 .BLKW #1 
	
	THE_VALUE_3200 .FILL #-3   ; Hard-coded value to load into R1

.END  ; End of SUB_FILL_REGISTER_3200 subroutine

;=======================================================================
; Subroutine: SUB_PRINT_DECIMAL_3400
; Parameter: (R1) The number to print
; Postcondition: Takes the value in R1 and prints the decimal to console
;=======================================================================
.ORIG x3400

; SUB_PRINT_DECIMAL_3400 subroutine
SUB_PRINT_DECIMAL_3400

	; Backup register values
	ST R0, BACKUP_R0_3400 ; Store R0 value in memory
	ST R1, BACKUP_R1_3400 ; Store R1 value in memory
	ST R2, BACKUP_R2_3400 ; Store R2 value in memory
	ST R3, BACKUP_R3_3400 ; Store R3 value in memory
	ST R4, BACKUP_R4_3400 ; Store R4 value in memory
	ST R5, BACKUP_R5_3400 ; Store R5 value in memory
	ST R6, BACKUP_R6_3400 ; Store R6 value in memory
	ST R7, BACKUP_R7_3400 ; Store R7 value in memory
		
	; Check if negative
	LD R0, NEG_CHECK_3400 ; Load NEG_CHECK_3400 value into R0
	LD R2, BACKUP_R1_3400 ; Load R1 value into R2 (to check for negativity)
	AND R1, R1, R0 ; Perform bitwise AND operation to check if negative
	BRz BYPASS_NEG_PRINT_3400 ; If not negative, skip negative sign printing
	
	; Print negative sign
	LD R0, NEG_SIGN_3400 ; Load NEG_SIGN_3400 value into R0
	OUT ; Output the negative sign
		
	; If it's negative, we flip to the 2's complement positive
	NOT R2, R2 ; Negate R2 value
	ADD R2, R2, #1 ; Add 1 to R2 (2's complement)
		
BYPASS_NEG_PRINT_3400
		
	ADD R1, R2, #0 ; Copy R2 (positive value) to R1
		
	AND R3, R3, x0 ; If we've gotten a non-zero, this will be positive (initialize R3)
		
	; 10000's
	LD R4, DEC_10000_3400 ; Load DEC_10000_3400 value into R4
	AND R2, R2, x0 ; Reset counter in R2
		
DET_10000_LOOP_3400
	ADD R1, R1, R4 ; Add R4 (10000) to R1
	BRn END_DET_10000_LOOP_3400 ; If result is negative, exit loop
	ADD R2, R2, #1 ; Increment counter (10000s)
	ADD R3, R3, #1 ; Increment counter (positive digits)
	BR DET_10000_LOOP_3400 ; Continue looping
	
END_DET_10000_LOOP_3400
	
	; Get the remainder back in R1
	NOT R4, R4 ; Negate R4
	ADD R4, R4, #1 ; Add 1 to get the 2's complement
	ADD R1, R1, R4 ; Add the remainder to R1
	
	ADD R2, R2, #0 ; Copy counter value to R2
	BRz SKIP_TO_1000_3400 ; If counter is zero, skip printing
	
	ADD R0, R2, #0 ; Copy counter value to R0
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	OUT ; Output the counter as ASCII character

	; 1000's
SKIP_TO_1000_3400
	LD R4, DEC_1000_3400 ; Load DEC_1000_3400 value into R4
	AND R2, R2, x0 ; Reset counter in R2
	
DET_1000_LOOP_3400
	ADD R1, R1, R4 ; Add R4 (1000) to R1
	BRn END_DET_1000_LOOP_3400 ; If result is negative, exit loop
	ADD R2, R2, #1 ; Increment counter (1000s)
	ADD R3, R3, #1 ; Increment counter (positive digits)
	BR DET_1000_LOOP_3400 ; Continue looping
	
END_DET_1000_LOOP_3400
	
	; Get the remainder back in R1
	NOT R4, R4 ; Negate R4
	ADD R4, R4, #1 ; Add 1 to get the 2's complement
	ADD R1, R1, R4 ; Add the remainder to R1
	
	ADD R2, R2, #0 ; Copy counter value to R2
	BRp PRINT_1000_3400 ; If counter is zero or negative, skip printing
	
CHECK_ZERO_1000_3400
	ADD R3, R3, #0 ; Reset positive digit counter
	BRp PRINT_1000_3400 ; If counter is zero or negative, skip printing
	BR END_PRINT_1000_3400 ; Only print 0 if we have encountered non-zero
	
PRINT_1000_3400
	ADD R0, R2, #0 ; Copy counter value to R0
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	OUT ; Output the counter as ASCII character
	
END_PRINT_1000_3400
	
	; 100's
	LD R4, DEC_100_3400 ; Load DEC_100_3400 value into R4
	AND R2, R2, x0 ; Reset counter in R2
	
DET_100_LOOP_3400
	ADD R1, R1, R4 ; Add R4 (100) to R1
	BRn END_DET_100_LOOP_3400 ; If result is negative, exit loop
	ADD R2, R2, #1 ; Increment counter (100s)
	ADD R3, R3, #1 ; Increment counter (positive digits)
	BR DET_100_LOOP_3400 ; Continue looping
	
END_DET_100_LOOP_3400
	
	; Get the remainder back in R1
	NOT R4, R4 ; Negate R4
	ADD R4, R4, #1 ; Add 1 to get the 2's complement
	ADD R1, R1, R4 ; Add the remainder to R1
	
	ADD R2, R2, #0 ; Copy counter value to R2
	BRp PRINT_100_3400 ; If counter is zero or negative, skip printing
	
CHECK_ZERO_100_3400
	ADD R3, R3, #0 ; Reset positive digit counter
	BRp PRINT_100_3400 ; If counter is zero or negative, skip printing
	BR END_PRINT_100_3400 ; Only print 0 if we have encountered non-zero
	
PRINT_100_3400
	ADD R0, R2, #0 ; Copy counter value to R0
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	OUT ; Output the counter as ASCII character
	
END_PRINT_100_3400
	
	; 10's
	LD R4, DEC_10_3400 ; Load DEC_10_3400 value into R4
	AND R2, R2, x0 ; Reset counter in R2
	
DET_10_LOOP_3400
	ADD R1, R1, R4 ; Add R4 (10) to R1
	BRn END_DET_10_LOOP_3400 ; If result is negative, exit loop
	ADD R2, R2, #1 ; Increment counter (10s)
	ADD R3, R3, #1 ; Increment counter (positive digits)
	BR DET_10_LOOP_3400 ; Continue looping
	
END_DET_10_LOOP_3400
	
	; Get the remainder back in R1
	NOT R4, R4 ; Negate R4
	ADD R4, R4, #1 ; Add 1 to get the 2's complement
	ADD R1, R1, R4 ; Add the remainder to R1
	
	ADD R2, R2, #0 ; Copy counter value to R2
	BRp PRINT_10_3400 ; If counter is zero or negative, skip printing
	
CHECK_ZERO_10_3400
	ADD R3, R3, #0 ; Reset positive digit counter
	BRp PRINT_10_3400 ; If counter is zero or negative, skip printing
	BR END_PRINT_10_3400 ; Only print 0 if we have encountered non-zero
	
PRINT_10_3400
	ADD R0, R2, #0 ; Copy counter value to R0
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	ADD R0, R0, #12 ; Convert counter to ASCII (add 48)
	OUT ; Output the counter as ASCII character
	
END_PRINT_10_3400
	
	; Print remaining number in R1
	ADD R0, R1, #0 ; Copy R1 value to R0
	ADD R0, R0, #12 ; Convert remaining number to ASCII (add 48)
	ADD R0, R0, #12 ; Convert remaining number to ASCII (add 48)
	ADD R0, R0, #12 ; Convert remaining number to ASCII (add 48)
	ADD R0, R0, #12 ; Convert remaining number to ASCII (add 48)
	OUT ; Output the remaining number as ASCII character

	; Restore register values
	LD R0, BACKUP_R0_3400 ; Load R0 value from memory
	LD R1, BACKUP_R1_3400 ; Load R1 value from memory
	LD R2, BACKUP_R2_3400 ; Load R2 value from memory
	LD R3, BACKUP_R3_3400 ; Load R3 value from memory
	LD R4, BACKUP_R4_3400 ; Load R4 value from memory
	LD R5, BACKUP_R5_3400 ; Load R5 value from memory
	LD R6, BACKUP_R6_3400 ; Load R6 value from memory
	LD R7, BACKUP_R7_3400 ; Load R7 value from memory
	RET ; Return from the subroutine

; Data section

BACKUP_R0_3400 .BLKW #1 ; Allocate memory for R0 backup
BACKUP_R1_3400 .BLKW #1 ; Allocate memory for R1 backup
BACKUP_R2_3400 .BLKW #1 ; Allocate memory for R2 backup
BACKUP_R3_3400 .BLKW #1 ; Allocate memory for R3 backup
BACKUP_R4_3400 .BLKW #1 ; Allocate memory for R4 backup
BACKUP_R5_3400 .BLKW #1 ; Allocate memory for R5 backup
BACKUP_R6_3400 .BLKW #1 ; Allocate memory for R6 backup
BACKUP_R7_3400 .BLKW #1 ; Allocate memory for R7 backup 
REMOVE_NEG_3400 .FILL x7FFF ; Value used to remove negative sign
NEG_CHECK_3400 .FILL x8000 ; Value used to check if negative
NEG_SIGN_3400 .Stringz "-" ; String containing the negative sign
DEC_10000_3400 .FILL #-10000 ; Value representing 10000
DEC_1000_3400 .FILL #-1000 ; Value representing 1000
DEC_100_3400 .FILL #-100 ; Value representing 100
DEC_10_3400 .FILL #-10 ; Value representing 10
.END