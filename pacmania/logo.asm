    DEVICE ZXSPECTRUM48

logo_depacker
            DI
            CALL 0x0052
            DEC SP
            DEC SP
            POP BC
            LD HL,0x0097
            ADD HL,BC
            EX DE,HL
            LD HL,0x0066
            ADD HL,BC
            LD (HL),E
            INC HL
            LD (HL),D
            LD HL,0x007B
            ADD HL,BC
            LD (HL),E
            INC HL
            LD (HL),D
            LD HL,0x0089
            ADD HL,BC
            LD (HL),E
            INC HL
            LD (HL),D
            LD HL,0x00BE
            ADD HL,BC
            LD DE,0x4000
            PUSH DE
            EXX
            EX AF,AF'
            LD A,0x03
            OR A
            LD B,0x08
            LD C,B
            POP HL
            EX AF,AF'
            EXX
label_D2A5
            LD A,(HL)
            BIT 7,A
            JR NZ,label_D2E4
            AND 0x07
            LD C,A
            LD A,(HL)
            RRCA
            RRCA
            RRCA
            AND 0x0F
            ADD A,0x03
            LD B,A
            INC HL
            LD A,E
            SUB (HL)
            INC HL
            PUSH HL
            LD L,A
            LD A,D
            SBC A,C
            LD H,A
label_D2BF
            PUSH HL
            LD A,H
            AND 0x58
            CP 0x58
            JR Z,label_D2D9
            LD C,A
            LD A,L
            AND 0x07
            OR C
            LD C,A
            ADD HL,HL
            ADD HL,HL
            LD A,H
            AND 0x1F
            LD H,A
            LD A,L
            AND 0xE0
            OR H
            LD L,A
            LD H,C
label_D2D9
            LD A,(HL)
            CALL 0xc3c3
            POP HL
            INC HL
            DJNZ label_D2BF
            POP HL
            JR label_D2A5
label_D2E4
            AND 0x7F
            JR Z,label_D305
            INC HL
            BIT 6,A
            JR NZ,label_D2F7
            LD B,A
label_D2EE
            LD A,(HL)
            CALL 0xc3c3
            INC HL
            DJNZ label_D2EE
            JR label_D2A5
label_D2F7
            AND 0x3F
            ADD A,0x03
            LD B,A
            LD A,(HL)
label_D2FD
            CALL 0xc3c3
            DJNZ label_D2FD
            INC HL
            JR label_D2A5
label_D305:
            EXX
            LD HL,0x2758
            EXX
            EI
            RET
    INCBIN "logo.bin"
