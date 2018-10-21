RCR:            EQU       36H             ; REFRESH CONT REG
ITC:            EQU       34H             ; INT/TRAP CONT REG
OMCR_M1E:       EQU       80H 
OMCR:           EQU       3EH
CMR:            EQU       1EH
DCNTL_IWI0:     EQU       10H
DCNTL:          EQU       32H
CBR:            EQU       38H    ; MMU COMMON BASE REG
BBR:            EQU       39H    ; MMU BANK BASE REG
CBAR:           EQU       3AH    ; MMU COMMON/BANK AREA REG
          
ASCI_RE:        EQU       40H     ; RECEIVE ENABLE
ASCI_TE:        EQU       20H     ; TRANSMIT ENABLE

ASCI_8N1:       EQU       04H     ; 8 BITS NO PARITY 1 STOP BIT


WRKSPC:         EQU       2700H           ; SET BASIC WORK SPACE WRKSPC
TEMPSTACK:      EQU       WRKSPC + 0ABH 


ROMSTART:        EQU   $0000   ; BOTTOM OF COMMON 0 FLASH
ROMSTOP:         EQU   $BFFF   ; TOP OF COMMON 0 FLASH

RAMSTART_CA0:    EQU   $C000   ; BOTTOM OF COMMON 0 RAM
RAMSTOP_CA0:     EQU   $DFFF   ; TOP OF COMMON 0 RAM

RAMSTART_BANK:   EQU   $E000   ; BOTTOM OF BANKED RAM
RAMSTOP_BANK:    EQU   $EFFF   ; TOP OF BANKED RAM

RAMSTART_CA1:    EQU   $F000   ; BOTTOM OF COMMON 1 RAM
RAMSTOP_CA1:     EQU   $FFFF   ; TOP OF COMMON 1 RAM


ASCI0RXBUF:         EQU     RAMSTART_CA0 + 40H
ASCI0TXBUF:         EQU     ASCI0RXBUF + 256

CNTLA0:             EQU         00H
CNTLB0:             EQU         02H  
STAT0:              EQU         04H
STAT0_RIE:          EQU         08H
CPU_CLOCK:          EQU         6144000
CPU_TIMER_SCALE:    EQU     20                  ; PRT SCALE FACTOR (FIXED)
RLDR0L:             EQU     0EH
RLDR0H:             EQU     0FH
ASCI_TIE:           EQU     01H
ASCI_RIE:           EQU     08H
TDR0:               EQU     06H  
TCR:                EQU     10H
TCR_TIE0:           EQU     10H
TCR_TDE0:           EQU     01H
DCNTL_MWI0:         EQU     40H     ; Memory Wait Insertion 0 (1 Default)
CNTLA0_RE:          EQU     40H
DCNTL_IWI1:         EQU     20H  
CNTLA0_TE:          EQU     20H  
CNTLA0_MODE_8N1:    EQU     04H
CNTLB0_SS_DIV_2:    EQU     01H

CMR_X2:             EQU     80H
CCR_XTAL_X2:        EQU     80H
CCR:                EQU     1FH         


.ORG 00000H

INIT_UART:
          
        XOR     A               ; ZERO ACCUMULATOR

                                   ; CLEAR REFRESH CONTROL REG (RCR)
        OUT0    (RCR),A         ; DRAM REFRESH ENABLE (0 DISABLED)

                                   ; CLEAR INT/TRAP CONTROL REGISTER (ITC)            
        OUT0    (ITC),A         ; DISABLE ALL EXTERNAL INTERRUPTS.            

                                   ; SET OPERATION MODE CONTROL REG (OMCR)
        LD      A,OMCR_M1E      ; ENABLE M1 FOR SINGLE STEP, DISABLE 64180 I/O _RD MODE
        OUT0    (OMCR),A        ; X80 MODE (M1 DISABLED, IOC DISABLED)


                               ; Set PHI = CCR x 2 = 36.864MHz
                            ; if using ZS8180 or Z80182 at High-Speed
    ld      a,CMR_X2        ; Set Hi-Speed flag
    out0    (CMR),a         ; CPU Clock Multiplier Reg (CMR)

                            ; Set CCR = crystal = 18.432MHz
                            ; if using ZS8180 or Z80182 at High-Speed
    ld      a,CCR_XTAL_X2   ; Set Hi-Speed flag
    out0    (CCR),a         ; CPU Control Reg (CCR)

                                   ; SET INTERNAL CLOCK = CRYSTAL X 2 = 36.864MHZ
                                   ; IF USING ZS8180 OR Z80182 AT HIGH-SPEED
          
                                   ; DMA/WAIT CONTROL REG SET I/O WAIT STATES
        LD      A,DCNTL_MWI0|DCNTL_IWI1
        OUT0    (DCNTL),A       ; 1 MEMORY WAIT & 3 I/O WAIT
                                   ; SET LOGICAL RAM ADDRESSES
                                   ; $2000-$FFFF RAM   CA1 -> $2N
                                   ; $0000-$1FFF FLASH BANK -> $N0

        LD      A,$F0           ; SET NEW COMMON 1 / BANK AREAS FOR RAM
        OUT0    (CBAR),A

        LD      A,$00           ; SET COMMON 1 BASE PHYSICAL $0F000 -> $00
        OUT0    (CBR),A

        LD      A,$00           ; SET BANK BASE PHYSICAL $00000 -> $00
        OUT0    (BBR),A

                                   ; LOAD THE DEFAULT ASCI CONFIGURATION
                                   ; BAUD = 115200 8N1
                                   ; RECEIVE ENABLED
                                   ; TRANSMIT ENABLED
                                   ; RECEIVE INTERRUPT ENABLED
                                   ; TRANSMIT INTERRUPT DISABLE
                                   ;   PROGRAMMABLE RELOAD TIMER (TCR)

                                   ; WE DO 256 TICKS PER SECOND
        LD      HL, CPU_CLOCK/CPU_TIMER_SCALE/256-1
        OUT0    (RLDR0L), L
        OUT0    (RLDR0H), H
                                   ; ENABLE DOWN COUNTING AND INTERRUPTS FOR PRT0
        LD      A, TCR_TIE0|TCR_TDE0
        OUT0    (TCR), A

          

        EX (SP),HL
        PUSH HL

        LD A,I
 
        DI
 
        PUSH AF
        POP HL                      ; HL = EI_DI STATUS
 
        POP AF                      ; AF = RET
        EX (SP),HL                  ; RESTORE HL, PUSH EI_DI_STATUS
 
        PUSH AF

        LD      A,CNTLA0_RE|CNTLA0_TE|CNTLA0_MODE_8N1
        OUT0    (CNTLA0),A          ; OUTPUT TO THE ASCI0 CONTROL A REG

                                   ; PHI / PS / SS / DR = BAUD RATE
                                   ; PHI = 36.864MHZ
                                   ; BAUD = 115200 = 36864000 / 10 / 2 / 16
                                   ; PS 0, SS_DIV_2, DR 0
        LD A,CNTLB0_SS_DIV_2
        OUT0    (CNTLB0),A          ; OUTPUT TO THE ASCI0 CONTROL B REG

        LD      A,STAT0_RIE         ; RECEIVE INTERRUPT ENABLED
        OUT0    (STAT0),A           ; OUTPUT TO THE ASCI0 STATUS REG

        POP AF                      ; AF = EI_DI_STATUS
        DI


START:                                    
        LD A, 'A'               ; "#" PER LINE LOADED
        PUSH HL                     ; STORE HL SO WE DON'T CLOBBER IT       
        LD L, A                     ; STORE TX CHARACTER
       LD A, L                     ; RETRIEVE TX CHARACTER
       LD (HL), A                  ; WRITE THE TX BYTE TO THE ASCI0TXINPTR  

       INC L                       ; MOVE THE TX POINTER LOW BYTE ALONG, 0XFF ROLLOVER
       POP HL                      ; RECOVER HL

       IN0 A, (STAT0)              ; LOAD THE ASCI0 STATUS REGISTER
       
       DI                          ; CRITICAL SECTION BEGIN
       IN0 A, (STAT0)              ; GET THE ASCI STATUS REGISTER AGAIN
       OR ASCI_TIE                 ; MASK IN (ENABLE) THE TX INTERRUPT
       OUT0 (STAT0), A             ; SET THE ASCI STATUS REGISTER
       EI                          ; CRITICAL SECTION END
       IN0 A, (STAT0)              ; GET THE ASCI0 STATUS REGISTER

       LD A, L                     ; RETRIEVE TX CHARACTER FOR IMMEDIATE TX
       OUT0 (TDR0), A              ; OUTPUT THE TX BYTE TO THE ASCI0

       POP HL                      ; RECOVER HL

