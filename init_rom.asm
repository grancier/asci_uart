

    ORG FFFFH

   ; Z8S180 / Z8L180 CLASS
   
   DEFC    CPU_CLOCK       =   6144000
   DEFC    CPU_TIMER_SCALE =       20                  ; PRT Scale Factor (Fixed)
   defc CNTLA0 = 0x0
   defc CNTLA1 = 0x1
   defc CNTLB0 = 0x2
   defc CNTLB1 = 0x3
   defc STAT0 = 0x4
   defc STAT1 = 0x5
   defc TDR0 = 0x6
   defc TDR1 = 0x7
   defc RDR0 = 0x8
   defc RDR1 = 0x9
   defc ASEXT0 = 0x12
   defc ASEXT1 = 0x13
   defc ASTC0L = 0x1a
   defc ASTC0H = 0x1b
   defc ASTC1L = 0x1c
   defc ASTC1H = 0x1d

   DEFC    ASCI_RE         =       $40     ; Receive Enable
   DEFC    ASCI_TE         =       $20     ; Transmit Enable
   DEFC    ASCI_8P2        =       $07     ; 8 Bits    Parity 2 Stop Bits
   DEFC    ASCI_8P1        =       $06     ; 8 Bits    Parity 1 Stop Bit
   DEFC    ASCI_8N2        =       $05     ; 8 Bits No Parity 2 Stop Bits
   DEFC    ASCI_8N1        =       $04     ; 8 Bits No Parity 1 Stop Bit
   DEFC    ASCI_7P2        =       $03     ; 7 Bits    Parity 2 Stop Bits
   DEFC    ASCI_7P1        =       $02     ; 7 Bits    Parity 1 Stop Bit
   DEFC    ASCI_7N2        =       $01     ; 7 Bits No Parity 2 Stop Bits
   DEFC    ASCI_7N1        =       $00     ; 7 Bits No Parity 1 Stop Bit
   
   ;   ASCI Status Reg (STATn)
   DEFC    ASCI_RDRF       =       $80     ; Receive Data Register Full
   DEFC    ASCI_OVRN       =       $40     ; Overrun (Received Byte)
   DEFC    ASCI_PE         =       $20     ; Parity Error (Received Byte)
   DEFC    ASCI_FE         =       $10     ; Framing Error (Received Byte)
   DEFC    ASCI_RIE        =       $08     ; Receive Interrupt Enabled
   DEFC    ASCI_DCD0       =       $04     ; _DCD0 Data Carrier Detect USART0
   DEFC    ASCI_CTS1       =       $04     ; _CTS1 Clear To Send USART1
   DEFC    ASCI_TDRE       =       $02     ; Transmit Data Register Empty
   DEFC    ASCI_TIE        =       $01     ; Transmit Interrupt Enabled


   defc CNTR = 0xa
   defc TRDR = 0xb

   defc TMDR0L = 0xc
   defc TMDR0H = 0xd
   defc RLDR0L = 0xe
   defc RLDR0H = 0xf
   defc TCR = 0x10
   defc TMDR1L = 0x14
   defc TMDR1H = 0x15
   defc RLDR1L = 0x16
   defc RLDR1H = 0x17

   defc FRC = 0x18
   defc CMR = 0x1e
   defc CCR = 0x1f

   defc SAR0L = 0x20
   defc SAR0H = 0x21
   defc SAR0B = 0x22
   defc DAR0L = 0x23
   defc DAR0H = 0x24
   defc DAR0B = 0x25
   defc BCR0L = 0x26
   defc BCR0H = 0x27
   defc MAR1L = 0x28
   defc MAR1H = 0x29
   defc MAR1B = 0x2a
   defc IAR1L = 0x2b
   defc IAR1H = 0x2c
   defc IAR1B = 0x2d
   defc BCR1L = 0x2e
   defc BCR1H = 0x2f
   defc DSTAT = 0x30
   defc DMODE = 0x31
   defc DCNTL = 0x32

   defc IL = 0x33
   defc ITC = 0x34

   defc RCR = 0x36

   defc CBR = 0x38
   defc BBR = 0x39
   defc CBAR = 0x3a

   defc OMCR = 0x3e
   defc ICR = 0x3f

   ; I/O REGISTER BIT FIELDS

   defc CNTLA0_MPE = 0x80
   defc CNTLA0_RE = 0x40
   defc CNTLA0_TE = 0x20
   defc CNTLA0_RTS0 = 0x10
   defc CNTLA0_MPBR = 0x08
   defc CNTLA0_EFR = 0x08
   defc CNTLA0_MODE_MASK = 0x07
   defc CNTLA0_MODE_8P2 = 0x07
   defc CNTLA0_MODE_8P1 = 0x06
   defc CNTLA0_MODE_8N2 = 0x05
   defc CNTLA0_MODE_8N1 = 0x04
   defc CNTLA0_MODE_7P2 = 0x03
   defc CNTLA0_MODE_7P1 = 0x02
   defc CNTLA0_MODE_7N2 = 0x01
   defc CNTLA0_MODE_7N1 = 0x00

   defc CNTLA1_MPE = 0x80
   defc CNTLA1_RE = 0x40
   defc CNTLA1_TE = 0x20
   defc CNTLA1_CKA1D = 0x10
   defc CNTLA1_MPBR = 0x08
   defc CNTLA1_EFR = 0x08
   defc CNTLA1_MODE_MASK = 0x07
   defc CNTLA1_MODE_8P2 = 0x07
   defc CNTLA1_MODE_8P1 = 0x06
   defc CNTLA1_MODE_8N2 = 0x05
   defc CNTLA1_MODE_8N1 = 0x04
   defc CNTLA1_MODE_7P2 = 0x03
   defc CNTLA1_MODE_7P1 = 0x02
   defc CNTLA1_MODE_7N2 = 0x01
   defc CNTLA1_MODE_7N1 = 0x00

   defc CNTLB0_MPBT = 0x80
   defc CNTLB0_MP = 0x40
   defc CNTLB0_CTS = 0x20
   defc CNTLB0_PS = 0x20
   defc CNTLB0_PEO = 0x10
   defc CNTLB0_DR = 0x08
   defc CNTLB0_SS_MASK = 0x07
   defc CNTLB0_SS_EXT = 0x07
   defc CNTLB0_SS_DIV_64 = 0x06
   defc CNTLB0_SS_DIV_32 = 0x05
   defc CNTLB0_SS_DIV_16 = 0x04
   defc CNTLB0_SS_DIV_8 = 0x03
   defc CNTLB0_SS_DIV_4 = 0x02
   defc CNTLB0_SS_DIV_2 = 0x01
   defc CNTLB0_SS_DIV_1 = 0x00

   defc CNTLB1_MPBT = 0x80
   defc CNTLB1_MP = 0x40
   defc CNTLB1_CTS = 0x20
   defc CNTLB1_PS = 0x20
   defc CNTLB1_PEO = 0x10
   defc CNTLB1_DR = 0x08
   defc CNTLB1_SS_MASK = 0x07
   defc CNTLB1_SS_EXT = 0x07
   defc CNTLB1_SS_DIV_64 = 0x06
   defc CNTLB1_SS_DIV_32 = 0x05
   defc CNTLB1_SS_DIV_16 = 0x04
   defc CNTLB1_SS_DIV_8 = 0x03
   defc CNTLB1_SS_DIV_4 = 0x02
   defc CNTLB1_SS_DIV_2 = 0x01
   defc CNTLB1_SS_DIV_1 = 0x00

   defc STAT0_RDRF = 0x80
   defc STAT0_OVRN = 0x40
   defc STAT0_PE = 0x20
   defc STAT0_FE = 0x10
   defc STAT0_RIE = 0x08
   defc STAT0_DCD0 = 0x04
   defc STAT0_TDRE = 0x02
   defc STAT0_TIE = 0x01

   defc STAT1_RDRF = 0x80
   defc STAT1_OVRN = 0x40
   defc STAT1_PE = 0x20
   defc STAT1_FE = 0x10
   defc STAT1_RIE = 0x08
   defc STAT1_CTS1E = 0x04
   defc STAT1_TDRE = 0x02
   defc STAT1_TIE = 0x01

   defc CNTR_EF = 0x80
   defc CNTR_EIE = 0x40
   defc CNTR_RE = 0x20
   defc CNTR_TE = 0x10
   defc CNTR_SS_MASK = 0x07
   defc CNTR_SS_EXT = 0x07
   defc CNTR_SS_DIV_1280 = 0x06
   defc CNTR_SS_DIV_640 = 0x05
   defc CNTR_SS_DIV_320 = 0x04
   defc CNTR_SS_DIV_160 = 0x03
   defc CNTR_SS_DIV_80 = 0x02
   defc CNTR_SS_DIV_40 = 0x01
   defc CNTR_SS_DIV_20 = 0x00

   ; PRT REGISTER BIT FIELDS

   defc TCR_TIF1 = 0x80
   defc TCR_TIF0 = 0x40
   defc TCR_TIE1 = 0x20
   defc TCR_TIE0 = 0x10
   defc TCR_TOC1 = 0x08
   defc TCR_TOC0 = 0x04
   defc TCR_TDE1 = 0x02
   defc TCR_TDE0 = 0x01

   ; DMA REGISTER BIT FIELDS

   defc DSTAT_DE1 = 0x80
   defc DSTAT_DE0 = 0x40
   defc DSTAT_DWE1 = 0x20
   defc DSTAT_DWE0 = 0x10
   defc DSTAT_DIE1 = 0x08
   defc DSTAT_DIE0 = 0x04
   defc DSTAT_DME = 0x01

   defc DMODE_DM1 = 0x20
   defc DMODE_DM0 = 0x10
   defc DMODE_SM1 = 0x08
   defc DMODE_SM0 = 0x04
   defc DMODE_MMOD = 0x02

   defc DCNTL_MWI1 = 0x80
   defc DCNTL_MWI0 = 0x40
   defc DCNTL_IWI1 = 0x20
   defc DCNTL_IWI0 = 0x10
   defc DCNTL_DMS1 = 0x08
   defc DCNTL_DMS0 = 0x04
   defc DCNTL_DIM1 = 0x02
   defc DCNTL_DIM0 = 0x01

   ; INT/TRAP CONTROL REGISTER (ITC) BIT FIELDS

   defc ITC_TRAP = 0x80
   defc ITC_UFO = 0x40
   defc ITC_ITE2 = 0x04
   defc ITC_ITE1 = 0x02
   defc ITC_ITE0 = 0x01

   ; Refresh CONTROL REGISTER (RCR) BIT FIELDS

   defc RCR_REFE = 0x80
   defc RCR_REFW = 0x40
   defc RCR_CYC1 = 0x02
   defc RCR_CYC0 = 0x01

   ; Operation Mode CONTROL REGISTER (OMCR) BIT FIELDS

   defc OMCR_M1E = 0x80
   defc OMCR_M1TE = 0x40
   defc OMCR_IOC = 0x20

   ; CPU CLOCK MULTIPLIER REGISTER (CMR) BIT FIELDS (Z8S180 & higher Only)

   defc CMR_X2 = 0x80
   defc CMR_LN_XTAL = 0x40

   ; CPU CONTROL REGISTER (CCR) BIT FIELDS (Z8S180 & higher Only)

   defc CCR_XTAL_X2 = 0x80
   defc CCR_STANDBY = 0x40
   defc CCR_BREXT = 0x20
   defc CCR_LNPHI = 0x10
   defc CCR_IDLE = 0x08
   defc CCR_LNIO = 0x04
   defc CCR_LNCPUCTL = 0x02
   defc CCR_LNAD = 0x01


INITTAB:    
    XOR     A               ; Zero Accumulato
                            ; Clear Refresh Control Reg (RCR)
    out0    (RCR),a         ; DRAM Refresh Enable (0 Disabled)

                            ; Clear INT/TRAP Control Register (ITC)             
    out0    (ITC),a         ; Disable all external interrupts.             

                            ; Set Operation Mode Control Reg (OMCR)
    ld      a,OMCR_M1E      ; Enable M1 for single step, disable 64180 I/O _RD Mode
    out0    (OMCR),a        ; X80 Mode (M1 Disabled, IOC Disabled)

                            ; Set PHI = CCR x 2 = 36.864MHz
                            ; if using ZS8180 or Z80182 at High-Speed
    ld      a,CMR_X2        ; Set Hi-Speed flag
    out0    (CMR),a         ; CPU Clock Multiplier Reg (CMR)

                            ; Set CCR = crystal = 18.432MHz
                            ; if using ZS8180 or Z80182 at High-Speed
    ld      a,CCR_XTAL_X2   ; Set Hi-Speed flag
    out0    (CCR),a         ; CPU Control Reg (CCR)

                            ; DMA/Wait Control Reg Set I/O Wait States
    ld      a,DCNTL_MWI0|DCNTL_IWI1
    out0    (DCNTL),a       ; 1 Memory Wait & 3 I/O Wait

                            ; Set Logical RAM Addresses
                            ; $F000-$FFFF RAM   CA1  -> $F.
                            ; $C000-$EFFF RAM   BANK
                            ; $0000-$BFFF Flash BANK -> $.0

    ld      a,$C0           ; Set New Common 1 / Bank Areas for RAM
    out0    (CBAR),a

    ld      a,$00           ; Set Common 1 Base Physical $0F000 -> $00
    out0    (CBR),a

    ld      a,$00           ; Set Bank Base Physical $00000 -> $00
    out0    (BBR),a

    ;Init Asci0

    LD      A,ASCI_RE|ASCI_TE|ASCI_8N1
    OUT0    (CNTLA0),A      ; output to the ASCI0 control A reg

                                    ; PHI / PS / SS / DR = BAUD Rate
                                    ; PHI = 18.432MHz
                                    ; BAUD = 115200 = 18432000 / 10 / 1 / 16 
                                    ; PS 0, SS_DIV_1 0, DR 0           
    ld      a,CNTLB0_SS_DIV_2
    OUT0    (CNTLB0),A      ; output to the ASCI0 control B reg

    LD      A,ASCI_RIE      ; receive interrupt enabled
    OUT0    (STAT0),A       ; output to the ASCI0 status reg

    ld      hl, CPU_CLOCK/CPU_TIMER_SCALE/256-1 
    out0    (RLDR0L), l
    out0    (RLDR0H), h
                                    ; enable down counting and interrupts for PRT0
    ld      a, TCR_TIE0|TCR_TDE0
    out0    (TCR), a
    EI

PRINT_A:
    LD      HL,'A'      ; Sign-on message
    LD      A,(HL)              ; Get a byte
    OUT0    (TDR0), A              ; output the Tx byte to the ASCI0
    INC     HL
    JR      PRINT_A
    
MAIN:
    LD      HL,0C000H   ; Initialise 0Rx Buffer
    LD      SP,HL    ; Set up a temporary stack
    call INITTAB
    call PRINT_A
         
    

    
    

    