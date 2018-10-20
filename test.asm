RCR:            equ       36h             ; Refresh Cont Reg
ITC:            equ       34h             ; INT/TRAP Cont Reg
OMCR_M1E:       equ       80h  
OMCR:           equ       3eh
CMR:            equ       1eh
DCNTL_IWI0:     equ       10h
DCNTL:          equ       32h
CBR:            equ       38h    ; MMU Common Base Reg
BBR:            equ       39h    ; MMU Bank Base Reg
CBAR:           equ       3Ah    ; MMU Common/Bank Area Reg
            
ASCI_RE:        equ       40h     ; Receive Enable
ASCI_TE:        equ       20h     ; Transmit Enable

ASCI_8N1:       equ       04h     ; 8 Bits No Parity 1 Stop Bit


WRKSPC:         equ       2700h           ; set BASIC Work space WRKSPC
TEMPSTACK:      equ       WRKSPC + 0ABh  


ROMSTART:        equ   $0000   ; Bottom of Common 0 FLASH
ROMSTOP:         equ   $BFFF   ; Top of Common 0 FLASH

RAMSTART_CA0:    equ   $C000   ; Bottom of Common 0 RAM
RAMSTOP_CA0:     equ   $DFFF   ; Top of Common 0 RAM

RAMSTART_BANK:   equ   $E000   ; Bottom of Banked RAM
RAMSTOP_BANK:    equ   $EFFF   ; Top of Banked RAM

RAMSTART_CA1:    equ   $F000   ; Bottom of Common 1 RAM
RAMSTOP_CA1:     equ   $FFFF   ; Top of Common 1 RAM


ASCI0RxBuf:         equ     RAMSTART_CA0 + 40h
ASCI0TxBuf:         equ     ASCI0RxBuf + 256 

CNTLA0:             equ         00h
CNTLB0:             equ         02h   
STAT0:              equ         04h
CPU_CLOCK:          equ         6144000
CPU_TIMER_SCALE     equ     20                  ; PRT Scale Factor (Fixed)
RLDR0L:             equ     0Eh
RLDR0H:             equ     0Fh
ASCI_TIE:           equ     01h 
ASCI_RIE:           equ     08h
TDR0:               equ     06h   
TCR:                equ     10h
TCR_TIE0:           equ     10h
TCR_TDE0:           equ     01h

.ORG 00000H

INIT:
            
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
            LD      A,CMR        ; Set Hi-Speed flag
            OUT0    (CMR),A         ; CPU Clock Multiplier Reg (CMR)

                                    ; DMA/Wait Control Reg Set I/O Wait States
            LD      A,DCNTL_IWI0
            OUT0    (DCNTL),A       ; 0 Memory Wait & 2 I/O Wait

                                    ; Set Logical RAM Addresses
                                    ; $2000-$FFFF RAM   CA1 -> $2n
                                    ; $0000-$1FFF Flash BANK -> $n0

            LD      A,0C0h           ; Set New Common 1 / Bank Areas for RAM
            OUT0    (CBAR),A

            LD      A,$B0           ; Set Common 1 Base Physical $12000 -> $10
            OUT0    (CBR),A

            LD      A,$00           ; Set Bank Base Physical $00000 -> $00
            OUT0    (BBR),A

                                    ; load the default ASCI configuration
                                    ; BAUD = 115200 8n1
                                    ; receive enabled
                                    ; transmit enabled
                                    ; receive interrupt enabled
                                    ; transmit interrupt disable
                                    ;   Programmable Reload Timer (TCR)


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
            EI                      ; enable interrupts

TX0_BUFFER_OUT:

        ld a, l                     ; retrieve Tx character
        ld (hl), a                  ; write the Tx byte to the ASCI0TxInPtr   

        inc l                       ; move the Tx pointer low byte along, 0xFF rollover
        pop hl                      ; recover HL

        in0 a, (STAT0)              ; load the ASCI0 status register
        and ASCI_TIE                ; test whether ASCI0 interrupt is set
        ret nz                      ; if so then just return

        di                          ; critical section begin
        in0 a, (STAT0)              ; get the ASCI status register again
        or ASCI_TIE                 ; mask in (enable) the Tx Interrupt
        out0 (STAT0), a             ; set the ASCI status register
        ei                          ; critical section end
        ret


;------------------------------------------------------------------------------
TX0:
        push hl                     ; store HL so we don't clobber it        
        ld l, a                     ; store Tx character 

        jr nz, TX0_BUFFER_OUT       ; buffer not empty, so abandon immediate Tx

        in0 a, (STAT0)              ; get the ASCI0 status register

        ld a, l                     ; Retrieve Tx character for immediate Tx
        out0 (TDR0), a              ; output the Tx byte to the ASCI0

        pop hl                      ; recover HL
        ret                         ; and just complete

START:                                     
            LD A, 'A'               ; "#" per line loaded
            CALL    TX0       ; Output string
            