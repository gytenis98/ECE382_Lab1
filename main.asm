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
ADD_OP: 		.equ 	0x11
SUB_OP: 		.equ 	0x22
MUL_OP: 		.equ 	0x33
CLR_OP: 		.equ 	0x44
END_OP: 		.equ 	0x55
OPERAND: 		.equ 	r6
ACCUMULATOR:	.equ 	r5


				.data
Results: 		.space 	20


				.text
				.retain

				.retainrefs

;-------------------------------------------------------------------------------

RESET 		mov.w 		#__STACK_END,SP
StopWDT		mov.w 		#WDTPW|WDTHOLD,&WDTCTL

;-------------------------------------------------------------------------------
		; check loop here
CheckValues: 		.byte 			0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55 	; operation order


		mov.b 	#0, 			ACCUMULATOR
		mov.b 	#1, 			OPERAND

read
		mov.b 	CheckValues, 		ACCUMULATOR
		inc.b 	CheckValues

operand
		mov.b 	CheckValues, 		OPERAND
		inc.b 	CheckValues
		cmp.b 	&ADD_OP, 		OPERAND
		jmp 	addition
		cmp.b 	&SUB_OP, 		OPERAND
		jmp 	subtract
		cmp.b 	&MUL_OP, 		OPERAND
		jmp 	multiply
		cmp.b 	&CLR_OP, 		OPERAND
		jmp 	clear
		cmp.b 	&END_OP,	 	OPERAND
		jmp 	forever

addition
		add.b 	CheckValues,	 	ACCUMULATOR
		inc.b 	CheckValues
		mov.b 	ACCUMULATOR, 	Results
		inc.b 	CheckValues
		jc 		overFlow
		jmp 	operand

subtract
		sub.b 	CheckValues,	 	ACCUMULATOR
		inc.b 	CheckValues
		mov.b	ACCUMULATOR,	Results
		inc.b	Results
		jc 		overFlow0
		jmp 	operand

multiply
		mov.b 	CheckValues, 		&MPY
		inc.b 	CheckValues
		mov.b 	ACCUMULATOR,	&OP2
		NOP
		mov.b 	#RESLO, 		ACCUMULATOR
		jc 		overFlow
		jmp 	operand

clear
		mov.b 	#0, 			ACCUMULATOR
		inc.b 	CheckValues
		mov.b 	ACCUMULATOR, 	Results
		inc.b 	Results
		jmp 	operand

overFlow
		mov.b 	#255, 			ACCUMULATOR
		jmp 	operand

overFlow0
		mov.b 	#0, 			ACCUMULATOR
		jmp 	operand

forever jmp 	forever
