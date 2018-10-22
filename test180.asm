; GENERAL EQUATES

CTRLC   .EQU    03H             ; Control "C"
CTRLG   .EQU    07H             ; Control "G"
BKSP    .EQU    08H             ; Back space
LF      .EQU    0AH             ; Line feed
CS      .EQU    0CH             ; Clear screen
CR      .EQU    0DH             ; Carriage return
CTRLO   .EQU    0FH             ; Control "O"
CTRLQ	.EQU	11H             ; Control "Q"
CTRLR   .EQU    12H             ; Control "R"
CTRLS   .EQU    13H             ; Control "S"
CTRLU   .EQU    15H             ; Control "U"
ESC     .EQU    1BH             ; Escape
DEL     .EQU    7FH             ; Delete


init_com2:
    ; 8-n-1 -  transmit enabled, recieve enabled
    ;   the emulator doesn't seem to support the in0 and out0 instructions
    ;   which means I have to use the in/out z80 instructions, which put
    ;   the value in B on A8-A15.
    ;   in0 a, (cntla1)
    PUSH AF
    PUSH BC

	in0 a, (cntla1)			; kio 2015-01-06: wieder eingebaut für Testing
;	LD B, 0
;	IN A, (cntla1)
    
    OR 01100100B     ; RE=1, TE=1, CKA1D=0, M2 = 1, M1 = 0, M0 = 0
	
    out0 (cntla1), a			; kio 2015-01-06: wieder eingebaut für Testing
;    LD B, 0
;    OUT (cntla1), a

    POP BC
    POP AF
    RET
    

    ORG         0x0000

