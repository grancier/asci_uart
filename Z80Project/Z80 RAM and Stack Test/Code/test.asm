;***************************************************************************
;  PROGRAM:			RAM STACK TEST PROGRAM       
;  PURPOSE:			Key typed on PC will display. Demo CALL & RET. Init SP   
;  ASSEMBLER:		TASM 3.2        
;  LICENCE:			The MIT Licence
;  AUTHOR :			MCook
;  CREATE DATE :	04 Apr 15
;***************************************************************************

;ROM : 0000H - > 07FFH
;RAM : 8000H - > FFFFH 

RAMTOP:      .EQU    0FFFFH			; TOP ADDRESS OF RAM

.ORG 00H
			
MAIN:
			LD		SP,RAMTOP
			LD 		A,00H	
			CALL	INIT_UART
			JP		MAIN
			
INIT_UART:
			LD A,0AAH
			PUSH HL
			PUSH BC
			LD E,A
			LD (HL),A
			DEC BC
			LD A,B
			OR C
			LD A,E
			LD D,H
			LD D,L
			INC DE
			LDIR
			RET
			
;***************************************************************************
;GET_CHAR_UART
;Function: Get current character from UART place in Accumulator
;***************************************************************************
