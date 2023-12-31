    DEVICE ZXSPECTRUM48

music_init  EQU 0xea60
music_play  EQU 0xea66
music_stop  EQU 0xea60

    ORG 0xc000
main
            CALL init
            CALL music_init
main_loop
            HALT
            CALL music_play
            CALL cheat_keypress
            LD A,0x7f
            IN A,(0xfe)
            RRA
            JR C,main_loop
            IM 1
            LD A,0x3f
            LD I,A
            CALL music_stop
            LD HL,0x2758
            EXX
            LD IY,0x5c3a
            RET

im2_handler
            DI
            EXX
            PUSH AF
            CALL logo_draw
            CALL scroller_draw
            LD A,0xbf
            IN A,(0xfe)
            RRA
            CALL C,scroller_shift
            EXX
            POP AF
            EI
            RETI

down_d
            INC D
            LD A, 0x07
            AND D
            RET NZ
            LD A,E
            ADD A,0x20
            LD E,A
            RET C
            LD A,D
            SUB 0x08
            LD D,A
            RET
up_d
            DEC D
            LD A,D
            CPL
            AND 0x07
            RET NZ
            LD A,E
            SUB 0x20
            LD E,A
            CCF
            SBC A,A
            AND 0x08
            ADD A,D
            LD D,A
            RET
init
            LD HL,0x4000
            LD DE,0x4001
            LD BC,0x0fff
            LD (HL),L
            LDIR

            LD HL,0x5800
            LD DE,0x5801
            LD B,0x01
            LD A,0x47       ; paper black, ink white, bright on
            LD (HL),A
            LDIR
            LD BC,0x0140
            LD (HL),0x04
            LDIR
            LD C,0x20
            LD (HL),A
            LDIR

            LD HL,0x46e0
            LD DE,0x46e1
            LD C,0x1f
            LD (HL),0xff
            LDIR
            LD HL,0x5140
            LD DE,0x5141
            LD C,0x1f
            LD (HL),0xff
            LDIR

            DI
            LD HL,im2_handler
            LD (0xe9ff),HL
            LD A,0xe9
            LD I,A
            IM 2

            CALL cheat_init
            CALL logo_init
            CALL scroller_init
            LD HL,music_bin + music_bin_length - 1
            LD DE,music_init + music_bin_length - 1
            LD BC,music_bin_length
            LDDR
            EI
            RET

    INCLUDE "scroller.asm"
    INCLUDE "logopen.asm"
    INCLUDE "cheat.asm"
music_bin
    INCBIN "music.bin"
music_bin_length = $ - music_bin
main_end

    DISPLAY "750cc: code start=",main," length=",$-main
    SAVESNA "750cc.sna",main
