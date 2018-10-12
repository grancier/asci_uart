;***********************************
;*  UART Test Program              *
;*                                 *
;***********************************

.ORG 0000H

;******************************************************************
;INIT_UART
;Function: Initialize the UART to BAUD Rate 9600 (1.8432 MHz clock input)
;DLAB A2 A1 A0 Register
;0    0  0  0  Receiver Buffer (read),
;              Transmitter Holding
;              Register (write)
;0    0  0  1  Interrupt Enable
;X    0  1  0  Interrupt Identification (read)
;X    0  1  0  FIFO Control (write)
;X    0  1  1  Line Control
;X    1  0  0  MODEM Control
;X    1  0  1  Line Status
;X    1  1  0  MODEM Status
;X    1  1  1  Scratch
;1    0  0  0  Divisor Latch
;              (least significant byte)
;1    0  0  1  Divisor Latch
;              (most significant byte)
;******************************************************************

TDR0    EQU     06H     ;ASCI TX DATA REG CH0
CNTLA0_RE  EQU  40H
CNTLA0_TE  EQU  20H
CNTLA0_MODE_8N1  EQU  04H
CNTLA0  EQU     00H
CNTLB0_SS_DIV_2  EQU  01H
CNTLB0  EQU     02H
CNTLB1  EQU     03H
STAT0_RIE       EQU  08H
STAT0   EQU     04H     ;ASCI STATUS REG CH0

ASCI0TXCOUNT:    DEFB 0                 ; SPACE FOR TX BUFFER MANAGEMENT
ASCI0TXIN:       DEFW ASCI0TXBUFFER     ; NON-ZERO ITEM IN BSS SINCE IT'S INITIALIZED ANYWAY
ASCI0TXOUT:      DEFW ASCI0TXBUFFER     ; NON-ZERO ITEM IN BSS SINCE IT'S INITIALIZED ANYWAY
ASCI0TXLOCK:     DEFB $FE               ; LOCK FLAG FOR TX EXCLUSION

ASCI0RXBUFFER:   DEFS 256   ; SPACE FOR THE RX BUFFER
ASCI0TXBUFFER:   DEFS 256   ; SPACE FOR THE TX BUFFER

INIT_UART:
			EX (SP),HL
			PUSH HL

			LD A,I
 
			DI
 
			PUSH AF
			POP HL                      ; HL = EI_DI STATUS
 
			POP AF                      ; AF = RET
			EX (SP),HL                  ; RESTORE HL, PUSH EI_DI_STATUS
 
			PUSH AF


 			LD A,CNTLA0_RE|CNTLA0_TE|CNTLA0_MODE_8N1
   			OUT (CNTLA0),A             ; OUTPUT TO THE ASCI0 CONTROL A REG
			LD A,CNTLB0_SS_DIV_2
   			OUT    (CNTLB0),A          ; OUTPUT TO THE ASCI0 CONTROL B REG
			LD A,STAT0_RIE              ; RECEIVE INTERRUPT ENABLED
   			OUT (STAT0),A              ; OUTPUT TO THE ASCI0 STATUS REG

			POP AF                      ; AF = EI_DI_STATUS
			
;******************************************************************
;Main Program
;Function: Display A->Z then a new line and loop
;******************************************************************

STAT0_TIE	EQU	01H
STAT0_TDRE	EQU	02H

CLEAN_UP_TX:
       IN0 A,(STAT0)               ; LOAD THE ASCI0 STATUS REGISTER
       AND STAT0_TIE               ; TEST WHETHER ASCI0 INTERRUPT IS SET
       RET NZ                      ; IF SO THEN JUST RETURN

       DI                          ; CRITICAL SECTION BEGIN
       IN0 A,(STAT0)               ; GET THE ASCI STATUS REGISTER AGAIN
       OR STAT0_TIE                ; MASK IN (ENABLE) THE TX INTERRUPT
       OUT0 (STAT0),A              ; SET THE ASCI STATUS REGISTER
       EI                          ; CRITICAL SECTION END
       RET

PUT_BUFFER_TX:
       EI
       LD A,(ASCI0TXCOUNT)         ; GET THE NUMBER OF BYTES IN THE TX BUFFER
       CP 256 - 1      ; CHECK WHETHER THERE IS SPACE IN THE BUFFER
       LD A,L                      ; TX BYTE

       LD L,1
       JR NC,CLEAN_UP_TX           ; BUFFER FULL, SO DROP THE TX BYTE AND CLEAN UP

       LD HL,ASCI0TXCOUNT
       DI
       INC (HL)                    ; ATOMIC INCREMENT OF TX COUNT
       LD HL,(ASCI0TXIN)           ; GET THE POINTER TO WHERE WE POKE
       EI
       LD (HL),A                   ; WRITE THE TX BYTE TO THE ASCI0TXIN

       INC L                       ; MOVE THE TX POINTER LOW BYTE ALONG
       LD (ASCI0TXIN),HL           ; WRITE WHERE THE NEXT BYTE SHOULD BE POKED

       LD L,0                      ; INDICATE TX BUFFER WAS NOT FULL


MAIN_LOOP:   
       ; ENTER    : L = CHAR TO OUTPUT
       ; EXIT     : L = 1 IF TX BUFFER IS FULL
       ;            CARRY RESET
       ; MODIFIES : AF, HL
       
       DI
       IN A,(STAT0)               ; GET THE ASCI0 STATUS REGISTER
       OUT (TDR0),A              ; OUTPUT THE TX BYTE TO THE ASCI0

       LD A,41H                     ; TX BYTE

    
       JR NC,CLEAN_UP_TX           ; BUFFER FULL, SO DROP THE TX BYTE AND CLEAN UP

       LD HL,ASCI0TXCOUNT
       DI
       INC (HL)                    ; ATOMIC INCREMENT OF TX COUNT
       LD HL,(ASCI0TXIN)           ; GET THE POINTER TO WHERE WE POKE
       EI
       LD (HL),A                   ; WRITE THE TX BYTE TO THE ASCI0TXIN

       LD (ASCI0TXIN),HL           ; WRITE WHERE THE NEXT BYTE SHOULD BE POKED

       IN A,(STAT0)               ; LOAD THE ASCI0 STATUS REGISTER
       AND STAT0_TIE               ; TEST WHETHER ASCI0 INTERRUPT IS SET
       RET NZ                      ; IF SO THEN JUST RETURN

       DI                          ; CRITICAL SECTION BEGIN
       IN A,(STAT0)               ; GET THE ASCI STATUS REGISTER AGAIN
       OR STAT0_TIE                ; MASK IN (ENABLE) THE TX INTERRUPT
       OUT0 (STAT0),A              ; SET THE ASCI STATUS REGISTER
       EI                          ; CRITICAL SECTION END

setup:  ld sp, 0ffffh
        ld a,00fh
        out (003h),a

loop:   ld a,0ffh
        out (002h),a
        call wait
        ld a,000h
        out (002h),a
        call wait
        jp loop

wait:   ld bc, 00010h
outer:  ld de, 00100h
inner:  dec de
        ld a, d
        or e
        jp nz, inner
        dec bc
        ld a, b
        or c
        jp nz, outer
        ret

       JP MAIN_LOOP


.END