;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;	Lab 1 - simply calculator
;	Gytenis Borusas, USAFA, 08 September 2014/ 14 September 2014
;	Ece 382
;	Instructor - Dr. George W. P. York
;
;-------------------------------------------------------------------------------

				.cdecls C,LIST,"msp430.h"

;-------------------------------------------------------------------------------
ADD_OP: 		.equ 	0x11		;addition operation
SUB_OP: 		.equ 	0x22		;subratrction operation
CLR_OP: 		.equ 	0x44		;clear operation
END_OP: 		.equ 	0x55		;halt operation
OPERAND: 		.equ 	r6
ACCUMULATOR:	.equ 	r5


				.data		;RAM
Results: 		.space 	20	;space for answers


				.text
				.retain

				.retainrefs

;-------------------------------------------------------------------------------

RESET 		mov.w 		#__STACK_END,SP
StopWDT		mov.w 		#WDTPW|WDTHOLD,&WDTCTL

;-------------------------------------------------------------------------------
		; check loop here
CheckValues: 		.byte 			0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55 	; operation order
;Here I add values for checking if program works.

		mov.b 	#0, 			ACCUMULATOR
		mov.b 	#1, 			OPERAND

read
		mov.b 	CheckValues, 		ACCUMULATOR  ;stores next value in accumulator
		inc.b 	CheckValues						 ;increments checking value

operand
		mov.b 	CheckValues, 		OPERAND		;moves value from my check command to operand location
		inc.b 	CheckValues						;increments it
		cmp.b 	&ADD_OP, 		OPERAND			;checks if it is addition
		jmp 	addition
		cmp.b 	&SUB_OP, 		OPERAND			;checks if it is subraction
		jmp 	subtract
		cmp.b 	&CLR_OP, 		OPERAND			;checks if it is clear command
		jmp 	clear
		cmp.b 	&END_OP,	 	OPERAND			;checks if it is halt command
		jmp 	forever

addition											;performes addition operation and stores the results
		add.b 	CheckValues,	 	ACCUMULATOR
		inc.b 	CheckValues
		mov.b 	ACCUMULATOR, 	Results
		inc.b 	CheckValues
		jc 		overFlow							;checks for overflow
		jmp 	operand

subtract											;performes subtraction operation and stores the results
		sub.b 	CheckValues,	 	ACCUMULATOR
		inc.b 	CheckValues
		mov.b	ACCUMULATOR,	Results
		inc.b	Results
		jc 		overFlow0							;checks for "0" overflow
		jmp 	operand

clear												;performes clear operation and stores the results
		mov.b 	#0, 			ACCUMULATOR
		inc.b 	CheckValues
		mov.b 	ACCUMULATOR, 	Results
		inc.b 	Results
		jmp 	operand

overFlow											;checks for overflow
		mov.b 	#255, 			ACCUMULATOR
		jmp 	operand

overFlow0											;checks for "0" overflow
		mov.b 	#0, 			ACCUMULATOR
		jmp 	operand

forever jmp 	forever								;traps program in forever loop
