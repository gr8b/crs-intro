    DEVICE ZXSPECTRUM48

music_init  EQU 0xc636
music_play  EQU 0xc63c
music_stop  EQU 0xc63c

    ORG 0x6000
main
            CALL init

main_loop
            HALT
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

init
            SUB A
            OUT (0xfe),A
            LD A,0x47
            LD (0x5c8d),A
            LD HL,0x5aff
            LD DE,0x5afe
            LD BC,0x02ff
            LD (HL),A
            LDDR
            LD A,0x02
            CALL 0x1601
            LD HL,bottom_message
panel_print_loop
            LD A,(HL)
            AND 0x7f
            RST 0x10
            RL (HL)
            INC HL
            JR NC,panel_print_loop
            LD A,0xff
            LD HL,0x4660        ; top line address
            LD DE,0x5180        ; bottom line address
            LD B,0x20
init_loop1
            LD (HL),A
            INC L
            LD (DE),A
            INC E
            DJNZ init_loop1

            LD HL,music
            LD DE,0xc636
            LD BC,music_length
            LDIR
            CALL music_init

            CALL masked_scroller.init
            RET

bottom_message
    db 0x16, 0x15, 0x01
    dm "SPACE - START   ENTER - FREEZ"
    db 0xc5

message
    INCLUDE "message.asm"
    INCLUDE "masked_scroller.asm"
music
    INCBIN "music.bin"
music_length = $ - music

main_end

    DISPLAY "flintstones: code start=",main," length=",$-main
    SAVESNA "flintstones.sna",main