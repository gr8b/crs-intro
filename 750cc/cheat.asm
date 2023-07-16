    DEVICE ZXSPECTRUM48

cheat_init
            LD HL,cheat_panel_gfx
            LD DE,0x5060
            LD A,0x08
cheat_init_loop1
            LD BC,0x00a0
            PUSH DE
            LDIR
            POP DE
            INC D
            DEC A
            JR NZ,cheat_init_loop1
            LD DE,0x5a60
            LD C,0xa0
            LDIR
            RET

cheat_keypress
            LD A,0x80
ref_cheat_keypress_delay = $ - 1
            RRCA
            LD (ref_cheat_keypress_delay),A
            RET NC
            LD HL,cheat_options
            LD A,0xf7
            IN A,(0xfe)
            CPL
            AND 0x0f
            RET Z
            LD B,0xff
cheat_keypress_key
            INC B
            RRA
            JR NC,cheat_keypress_key
            LD A,B
            ADD A,A
            ADD A,A
            LD C,A
            LD B,0x00
            ADD HL,BC
            LD E,(HL)
            INC HL
            LD D,(HL)
            INC HL
            LD B,(HL)
            INC HL
            LD A,(HL)
            CPL
            LD (HL),A
cheat_keypress_show
            LD A,(DE)
            XOR 0x5b
            LD (DE),A
            INC E
            DJNZ cheat_keypress_show
            RET

cheat_options
    dw 0x5aa5 : db 0x06, 0x00
    dw 0x5ac7 : db 0x07, 0x00
    dw 0x5ab7 : db 0x07, 0x00
    dw 0x5ad3 : db 0x09, 0x00

cheat_panel_gfx
    INCBIN "cheat.panel.bin"
