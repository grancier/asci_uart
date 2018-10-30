defc CNTLA0_RE = 0x40
defc CNTLA0_TE = 0x20
defc CNTLA0_MODE_8N1 = 0x04
defc CNTLA0 = 0x0
defc CNTLB0 = 0x2
defc CNTLB0_SS_DIV_64 = 0x06
defc CNTLB0_SS_DIV_32 = 0x05
defc CNTLB0_SS_DIV_16 = 0x04
defc CNTLB0_SS_DIV_8 = 0x03
defc CNTLB0_SS_DIV_4 = 0x02
defc CNTLB0_SS_DIV_2 = 0x01
defc CNTLB0_SS_DIV_1 = 0x00
defc STAT0_RIE = 0x08
defc STAT0 = 0x4
DEFC asci0TxLock                     = $F534
DEFC asci0RxLock                     = $F52E
asci0RxCount:   defb    0               ; Space for Rx Buffer Management 
asci0TxCount:   defb    0               ; Space for Tx Buffer Management
asciTxBuffer:   defs    0x080 + 0x080;
asci0TxIn:      defw    asciTxBuffer
asci0TxOut:     defw    asciTxBuffer

asci0RxBuffer:  defs    0x100
asci0RxIn:      defw    asci0RxBuffer 
asci0RxOut:     defw    asci0RxBuffer  

WRKSPC  .EQU    8000H
BRKFLG  .EQU    WRKSPC+4DH      ; Break flag

Z180_INIT:
            XOR     A               ; Zero Accumulator

                                    ; Clear Refresh Control Reg (RCR)
            OUT0    (RCR),A         ; DRAM Refresh Enable (0 Disabled)

                                    ; Clear INT/TRAP Control Register (ITC)             
            OUT0    (ITC),A         ; Disable all external interrupts.             

                                    ; Set Operation Mode Control Reg (OMCR)
            LD      A,OMCR_M1E      ; Enable M1 for single step, disable 64180 I/O _RD Mode
            OUT0    (OMCR),A        ; X80 Mode (M1 Disabled, IOC Disabled)

                                    ; Set internal clock = crystal x 2 = 36.864MHz
                                    ; if using ZS8180 or Z80182 at High-Speed
            LD      A,CMR_X2        ; Set Hi-Speed flag
            OUT0    (CMR),A         ; CPU Clock Multiplier Reg (CMR)

                                    ; DMA/Wait Control Reg Set I/O Wait States
            LD      A,DCNTL_IWI0
            OUT0    (DCNTL),A       ; 0 Memory Wait & 2 I/O Wait

                                    ; Set Logical RAM Addresses
                                    ; $2000-$FFFF RAM   CA1 -> $2n
                                    ; $0000-$1FFF Flash BANK -> $n0

            LD      A,$20           ; Set New Common 1 / Bank Areas for RAM
            OUT0    (CBAR),A

            LD      A,$10           ; Set Common 1 Base Physical $12000 -> $10
            OUT0    (CBR),A

            LD      A,$00           ; Set Bank Base Physical $00000 -> $00
            OUT0    (BBR),A

                                    ; load the default ASCI configuration
                                    ; BAUD = 115200 8n1
                                    ; receive enabled
                                    ; transmit enabled
                                    ; receive interrupt enabled
                                    ; transmit interrupt disabled

            LD      A,ASCI_RE|ASCI_TE|ASCI_8N1
            OUT0    (CNTLA0),A      ; output to the ASCI0 control A reg

                                    ; PHI / PS / SS / DR = BAUD Rate
                                    ; PHI = 18.432MHz
                                    ; BAUD = 115200 = 18432000 / 10 / 1 / 16 
                                    ; PS 0, SS_DIV_1 0, DR 0           
            XOR     A               ; BAUD = 115200
            OUT0    (CNTLB0),A      ; output to the ASCI0 control B reg

            LD      A,ASCI_RIE      ; receive interrupt enabled
            OUT0    (STAT0),A       ; output to the ASCI0 status reg

                                    ; we do 256 ticks per second
            ld      hl, CPU_CLOCK/CPU_TIMER_SCALE/256-1
            out0    (RLDR0L), l
            out0    (RLDR0H), h
                                    ; enable down counting and interrupts for PRT0
            ld      a, TCR_TIE0|TCR_TDE0
            out0    (TCR), a

            LD      SP,TEMPSTACK    ; Set up a temporary stack

            LD      HL,ASCI0RxBuf   ; Initialise 0Rx Buffer
            LD      (ASCI0RxInPtr),HL
            LD      (ASCI0RxOutPtr),HL

            LD      HL,ASCI0TxBuf   ; Initialise 0Tx Buffer
            LD      (ASCI0TxInPtr),HL
            LD      (ASCI0TxOutPtr),HL              

            XOR     A               ; 0 the ASCI0 Tx & Rx Buffer Counts
            LD      (ASCI0RxBufUsed),A
            LD      (ASCI0TxBufUsed),A

            EI                      ; enable interrupts


asm_asci0_flush_Rx:
    xor a
    ld (asci0RxCount),a         ; reset the Rx counter (set 0)
    ld hl,asci0RxBuffer         ; load Rx buffer pointer home
    ld (asci0RxIn),hl
    ld (asci0RxOut),hl
    ret

asm_asci0_flush_Tx:
    xor a
    ld (asci0TxCount),a         ; reset the Tx counter (set 0)
    ld hl,asciTxBuffer          ; load Tx buffer pointer home
    ld (asci0TxIn),hl
    ld (asci0TxOut),hl
    ret

INIT:   LD      HL,WRKSPC       ; Start of workspace RAM
        LD      SP,HL           ; Set up a temporary stack
        LD      A,0             ; Clear break flag
        LD      (BRKFLG),A
        CALL    Z180_INIT

MAIN:
        JP      INIT          ; Go to initialise

        JR      MAIN

END


