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
            ld	a,0
			ld	b,1
			ld	c,2
			ld	d,#3
			ld	e,4
			ld	h,5
			ld	l,6
			ld	hl,1234h
			ld	(hl),7
			in	a,(33)
			out	(33),a
			RET
			
;***************************************************************************
;GET_CHAR_UART
;Function: Get current character from UART place in Accumulator
;***************************************************************************
