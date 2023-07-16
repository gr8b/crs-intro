    DEVICE ZXSPECTRUM48

; available functions
; logo_init    Initialize code to draw logo animation
; logo_draw    Draw one frame of logo animation

logo_draw = 0xb0b5
; screen position to draw logo animation, x position should be set to 0
logo_draw_screen = 0x4000
logo_bin        INCBIN "logo.bin"
logo_bin_length = $ - logo_bin
logo_sin_bin    INCBIN "logo.sin.bin"
logo_sin_bin_length = $ - logo_sin_bin
; logo pendulum animation pre generated positions
; pre calculated for logo stored at logo_gfx_mem
logo_sin_mem = logo_sin_bin
; logo 8 copies, first shifted to right by 1px, next by 2px .. last by 0px
logo_gfx_mem = logo_draw - (logo_bin_length * 8)

    DISPLAY "logo_sin_mem: ",logo_sin_mem
    DISPLAY "logo_gfx_mem: ",logo_gfx_mem
    DISPLAY "logo_bin: ",logo_bin,", ",logo_bin_length
    DISPLAY "logo_sin_bin: ",logo_sin_bin,", ",logo_sin_bin_length

incd_ypos
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
logo_init
            LD DE,logo_gfx_mem + (8 * logo_bin_length) - 1
            LD BC,logo_bin_length
            LD HL,logo_bin + logo_bin_length - 1
            PUSH DE
            PUSH BC
            PUSH HL
            LDDR
            POP HL
            POP BC
            LD A,0x07       ; generate 7 copies shifted to left by 0,1,2..7px
logo_shift_loop1
            PUSH BC
            PUSH HL
logo_shift_loop2
            RL (HL)
            LDD
            JP PE,logo_shift_loop2
            POP HL
            POP BC
            DEC A
            JR NZ,logo_shift_loop1
            POP DE
            INC DE

            LD HL,logo_draw_code
            LD BC,logo_draw_code3 - logo_draw_code1
            LDIR
            EX DE,HL
            LD DE,logo_draw_screen
            LD C,0x30

logoline_generate_loop1
            PUSH DE
            LD B,0x10
logoline_generate_loop2
            LD (HL),0xE1    ; POP HL
            INC HL
            LD (HL),0x22    ; LD (xxxx),HL
            INC HL
            LD (HL),E
            INC HL
            LD (HL),D
            INC HL
            INC E
            INC E
            DJNZ logoline_generate_loop2
            DEC C
            JR Z,logo_generate_end
            PUSH BC
            EX DE,HL
            LD HL,logo_draw_code + (logo_draw_code3 - logo_draw_code1)
            LD C,logo_draw_code4 - logo_draw_code3
            LDIR
            EX DE,HL
            POP BC
            POP DE
            CALL incd_ypos
            JR logoline_generate_loop1
logo_generate_end
            POP AF              ; SP += 2
            EX DE,HL
            LD HL,logo_draw_code + (logo_draw_code4 - logo_draw_code1)
            LD C,logo_draw_code6 - logo_draw_code5
            LDIR
        IF logo_sin_bin != logo_sin_mem
            LD HL,logo_sin_bin
            LD DE,logo_sin_mem
            LD BC,logo_sin_bin_length
            LDIR
        ENDIF
            RET

logo_draw_code = $
    DISP logo_draw
logo_draw_code1
            DI
            LD (ref_logo_draw_stack),SP
            LD SP,0x3131
ref_logo_draw_sin = $ - 2
            LD A,0x01
ref_logo_draw_len = $ -1
            DEC A
            JR NZ,logo_draw_code2
            LD A,0x9D
            LD SP,logo_sin_mem
logo_draw_code2
            POP HL
            LD (ref_logo_draw_sin),SP
            LD (ref_logo_draw_len),A
            LD DE,0x0016                ; logo line width in bytes: 0x16 + 0x20
            LD SP,HL
logo_draw_code3
            LD H,D
            LD L,E
            ADD HL,SP
            LD SP,HL
logo_draw_code4
    ENT
    DISP logo_draw + 0x0cda
logo_draw_code5
            LD SP,0x3131
ref_logo_draw_stack = $ - 2 
            EI
            RET
logo_draw_code6
    ENT
