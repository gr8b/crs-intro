    DEVICE ZXSPECTRUM48

music_init  EQU 0xc000
music_play  EQU 0xc003
music_stop  EQU 0xc006

    ORG 0xb900
    INCBIN "font.bin"

main
            DI
            LD SP,0x5fb3
            LD HL,0x4000
            LD DE,0x5801
            LD BC,0x02ff
            XOR A
            LD (HL),A
            LDIR
            OUT (0xfe),A
            CALL logo_depacker
            LD A,0xa0
            LD I,A
            LD HL,0xffff
            LD (0xa0ff),HL
            LD A,0xc9
            LD (HL),A
            IM 2
            LD A,R
            AND 0x05
            CP 0x05
            JR NZ,supported_music_nr
            XOR A
supported_music_nr
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
            LD H,0x17
            ADD HL,HL
            ADD HL,HL
            ADD HL,HL
            LD (ref_char_addr),HL
skip_char_calc
            LD IX,0x0000
ref_char_addr = $ - 2
            LD HL,0x501f
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
            LD HL,0x59e2
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
            IM 1
            LD A,0xfe
            IN A,(0xfe)
            AND 0x08
            JP NZ,no_cheat_mode
            LD A,0x32           ; LD (xxxx),a
            LD (enable_cheat1),A
            LD (enable_cheat2),A
no_cheat_mode
            CALL music_stop
            LD HL,0x59e0
            XOR A
            LD B,0x60
_cls2
            LD (HL),A
            INC HL
            DJNZ _cls2
            LD HL,game_loader
            LD DE,0x5d40
            LD BC,0x0064
            PUSH DE
            LDIR
            RET
game_loader
    DISP   0x5d40
            LD HL,0
            LD (0x5c3d),HL
            LD DE,(0x5cf4)
            LD HL,0xc000
            LD BC,0x7ffd
            LD A,0x11           ; RAM 1
            OUT (C),A
            LD BC,0x0f05        ; load 0x0f sectors
            CALL 0x3d13
            DI
            CALL 0xc000         ; depack data on RAM 1
            LD BC,0x7ffd
            LD A,$10
            OUT (C),A
            LD HL,0x5fb4
            LD DE,(0x5cf4)
            LD BC,0x4e05
            CALL 0x3d13
            DI
            CALL 0x5fb4         ; depack data on RAM 0
            LD SP,0x5fff
            XOR A
enable_cheat1
            LD A,(0x8945)
enable_cheat2
            LD A,(0xb5bc)
            JP 0x7530           ; start game
    ENT

flashing_colors
    db 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x47, 0x47, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02
    db 0x00
message
    dm " HI ! MAD OF CRUSHERS PRESENTS GAME  P A C M A N I A  128(!!!)/48     GAME WAS RESTORED,"
    dm " INFINITED AND PACKED BY ME.  IF U WANNA GET SOME OTHERS(RESTORED) GAMES THEN WRITE TO : MAD , MATERA 31/49, E"
    db 0x01, 0x16
    dm "LGAVA, LV3001, LATVIA                       "
    db 0x01, 0x20
    dm "AND NOW TIME FOR GREETINGS :                MAD(T"
    db 0x01, 0x15
    dm "HANKS ME FOR RESTORED GAME),SPY,ALEX,DRYUNYA,ANDRIS KOTAN,STUDIO SPECCY,K&K,KIRILLER,MIMI,DAXY,WORLD SOFT,"
    dm "STUDIO 7,STUDIO A AND ETC.                     "
    db 0x01, 0x20
    dm "                 P.S.  ALL CODING, GRAFIX AND FNT FILE WAS WRITTEN BY ME.(NOW TIME IS 02:07 AND 30 SEC."
    dm " NOO 31 OPS ! 32 AGAING WRONG 33 AHHHH ! FIG S NIM !),MUSIC COMES FROM FAST FOOD 128(!!!!)    "
    dm "SEE U IN STUPID DEMO 1 !        BYE!                     BYE!                       "
    dm "PRESS 'C' FOR CHEAT !                 BYE!                                                 "
    db 0x00

    ORG 0xc000
    INCBIN "music.bin"
    INCLUDE "logo.asm"

    DISPLAY "pacmania: code start=",main," length=",$-main
    SAVESNA "pacmania.sna",main