.ORG 00000H

RAMTST:
            LD      A,D
            OR      E
            RET     Z
            LD      B,D
            LD      C,E

            SUB     A
            CALL    FILLCMP
            RET     C

            LD      A,0FFH
            CALL    FILLCMP
            RET     C

            LD      A,0AAH
            CALL    FILLCMP
            RET     C

            LD      A,55H
            CALL    FILLCMP
            RET     C


WLKLP:

            LD      A,10000000B
WLKLP1:     

            LD      (HL),A
            CP      (HL)
            SCF
            RET     NZ
            RRCA
            CP      10000000B
            JR      NZ,WLKLP1
            LD      (HL),0
            INC     HL
            DEC     BC
            LD      A,B
            OR      C
            JR      NZ,WLKLP
            RET

FILLCMP:

            PUSH    HL
            PUSH    BC
            LD      E,A
            LD      (HL),A
            DEC     BC
            LD      A,B
            OR      C
            LD      A,E
            JR      COMPARE


            LD      D,H
            LD      E,L
            INC     DE
            LDIR


COMPARE:

            POP     BC
            POP     HL
            PUSH    HL
            PUSH    BC

CMPLP:

            CPI
            JR      NZ,CMPER
            JP      PE,CMPLP


            POP     BC
            POP     HL
            OR      A
            RET

CMPER:

            POP     BC
            POP     DE
            SCF
            RET

MAIN:

            LD      HL,8000H
            LD      DE,7FFFH
            CALL    RAMTST

            JR      MAIN

END