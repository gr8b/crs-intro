    DEVICE ZXSPECTRUM48

font        EQU 0x7100
music_init  EQU 0xc000
music_play  EQU 0xc144

    ORG music_init - (music_bin - main)
main
            LD HL,font_bin
            LD DE,font
            LD BC,0x0200
            LDIR
            LD HL,0x5800
            LD DE,0x5801
            LD BC,0x02ff
            LD (HL),L
            LDIR
            LD HL,logo_bin
            LD DE,0x4800
            LD BC,0x0800
            LDIR
            LD HL,0x5940
            LD A,0x57
            LD C,0x60
            LD B,C
_cls1
            LD (HL),A
            INC L
            DJNZ _cls1
            LD B,C
            RES 6,A
_cls2
            LD (HL),A
            INC HL
            DJNZ _cls2
            LD B,0x20
_cls3
            LD (HL),0x47
            INC L
            DJNZ _cls3
            CALL music_init

main_loop
            LD A,0x01
ref_counter = $ - 1
            RRCA
            LD (ref_counter),A
            JR NC,skip_char_calc
            LD HL,message
ref_message = $ - 2
            LD A,(HL)
            OR A
            JR NZ,process_char
            LD HL,message
            LD A,(HL)
process_char
            CP 0x01
            INC HL
            JR NZ,skip_width_change
            LD A,(HL)
            LD (ref_shift_width),A
            INC HL
            LD A,(HL)
            INC HL
skip_width_change
            LD (ref_message),HL
            LD L,A
            LD H,0x0E
            ADD HL,HL
            ADD HL,HL
            ADD HL,HL
            LD (ref_char_addr),HL
skip_char_calc
            LD IX,0x0000
ref_char_addr = $ - 2
            LD HL,0x511f
            LD C,0x07
shift_lines
            LD E,L
            RLC (IX+0)
            LD B,0x20
ref_shift_width = $ - 1
shift_one_px
            RL (HL)
            DEC L
            DJNZ shift_one_px
            LD L,E
            INC H
            INC IX
            DEC C
            JP NZ,shift_lines
            LD A,0x11
ref_flash_counter = $ - 1
            RRCA
            LD (ref_flash_counter),A
            JR NC,skip_color_change
            LD HL,flashing_colors
ref_flashing_colors = $ - 2
            LD A,(HL)
            OR A
            JR NZ,skip_colors_init
            LD HL,flashing_colors
            LD A,(HL)
skip_colors_init
            INC HL
            LD (ref_flashing_colors),HL
            LD HL,0x5920
            LD B,27
fill_flash_color
            LD (HL),A
            INC L
            DJNZ fill_flash_color
            LD (HL),A

skip_color_change
            CALL music_play
            EI
            HALT
            DI
            XOR A
            IN A,(0xfe)
            CPL
            AND 0x1f
            JP Z,main_loop
            CALL music_init
    RET     ; code below starts game loading using TR-DOS call to 0x3d13
exit_intro
            IM 1
            LD HL,0x5a00
            LD B,L
_cls4
            LD (HL),0x00
            INC L
            DJNZ _cls4
            LD SP,0x5fb3
            LD HL,game_loader
            LD DE,0x5d40
            LD BC,0x00ff
            PUSH DE
            JP 0x33c3       ; ROM code: LDIR, RET

game_loader
    DISP   0x5d40
            LD HL,0x5fb4
            PUSH HL
            LD DE,(0x5cf4)
            LD BC,0x6105    ; load 0x61 sectors
load_retry
            PUSH HL
            PUSH DE
            PUSH BC
            CALL trload
            POP BC
            POP DE
            POP HL
            INC (IY+0)
            RET Z
            JR load_retry
trload
            LD (0x5c3d),SP
            LD (IY+0),0xff
            CALL 0x3d13
            RET
    ENT

flashing_colors
    db 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x47, 0x47, 0x07, 0x06, 0x05, 0x04, 0x03
    db 0x02, 0x01, 0x02, 0x03, 0x04, 0x03, 0x02, 0x01, 0x02, 0x03, 0x04, 0x05, 0x04, 0x03, 0x02
    db 0x00
message
    dm " YEP @@ MAD OF CRUSHERS BACK AND BRING YOU - S C A L E X T R I C - (SORRY  GUYS ONLY 48K VERSION @@@)"
    dm " THANKS TO A L E X  FOR TAPE VERSION !( HEY ! MAN ! DO YOU LIKE THIS CRACK ???.. BTW THANKS FOR LETTER  !)."
    dm "  AND NOW ...  WHAT NOW ? .. HM .... OH, YESS@ GREETINGS :      ALEX,DRYUNYA,AN"
    db 0x01, 0x15
    dm "DRIS KOTAN,STUDIO SPECCY,K AND K,PHANTASY (HEY ! DEPREDATOR I SAW GAUNTLET 2 (COOOL! EAHH@)"
    dm " BTW GUYS OF PHANTASY CONTACT CRUSHERS.. CONTACT ADRESS IN LATVIA IS : ELGAVA LV-3004,"
    dm " NERETAS ST. 10/50 ALEXANDR SHUBIN ),STUDIO 7 (NICE LOADERS ! SEND TO US YOUR WORKS.),"
    dm "WARRIORS (HEY ! WARRIRORS CONTACT US PLEASE TOO !),TECHNOSOFT (THE SAME AS ABOVE !),KIRILLER"
    dm " AND OTHERS UNKNOWN HACKERS,CODERS MUSICIANTS..                                "
    db 0x01, 0x20
    dm "            COMING SOON FROM CRUSHERS : SURPRISE MEGADEMO ( HEEEY ! WE STILL LOOKING FOR MUSICIANT ! )"
    dm ",PALETTE DEMO,ALEX BIRTHDAY,SOME DISK VERSIONS,SOFTWARE FILER,MD PACK,SOUND TRACKER 2+,"
    dm "TANK(MAD'N'SPY WORK) AND ETC.      THATS ALL ! C U LATER !                       CREDITS:"
    dm " MINI INTRO CODED,GAME D"
    db 0x01, 0x18
    dm "ISKED,RESTORED ( AFTER OPUS MULTIFACE ),ERRORS KILLED BY MAD ,"
    dm " THIS NICE SONG BY ALEX ...                               "
    db 0x01, 0x20
    dm "     "
    db 0x00
font_bin
    INCBIN  "font.bin"
logo_bin
    INCBIN  "logo.bin"
music_bin
    INCBIN  "music.bin"

    DISPLAY "scalextric: code start=",main," length=",$-main
    SAVESNA "scalextric.sna",main
