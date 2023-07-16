    DEVICE ZXSPECTRUM48

; available functions
; scroller_init    Initialize scroller buffer
; scroller_draw    Draw one frame of scroller
; scroller_shift   Scroll text by one position

scroller_buffer_mem = 0xfdde

scroller_init
            LD HL,scroller_buffer_mem
            LD DE,scroller_buffer_mem + 1
            LD BC,0x0300
            LD (HL),C
            LDIR
            RET

scroller_draw
            LD DE,0x4900
ref_scroller_draw_pos = $ - 2
data_BF6E:
            CALL clear_line
            LD A,0x00
ref_scroller_pos = $ - 1
            INC A
            AND 0x7f
            LD (ref_scroller_pos),A
            AND 0x40
            PUSH AF
            CALL Z,down_d
            POP AF
            CALL NZ,up_d
            LD (ref_scroller_draw_pos),DE
            LD HL,clear_line_down
            PUSH HL
            LD HL,scroller_buffer_mem
            LD BC,0x0200
scroller_screen_copy:
            PUSH DE
        DUP 32
            LDI
        EDUP
            INC HL
            INC HL
            POP DE
            RET PO
            CALL down_d
            JP scroller_screen_copy
clear_line_down
            CALL down_d
clear_line
            LD L,E
            XOR A
            LD B,0x20
clear_line_loop
            LD (DE),A
            INC E
            DJNZ clear_line_loop
            LD E,L
            RET

scroller_shift	
            LD HL,scroller_buffer_mem + 0x0220 - 1
            LD BC,0x2003
scroller_shift_loop1
            RLD
            DEC HL
            DJNZ scroller_shift_loop1
            DEC C
            JR NZ,scroller_shift_loop1
            LD A,0x88
ref_scroller_next_char = $ - 1
            RRCA
            LD (ref_scroller_next_char),A
            RET NC
            LD HL,message
ref_message_mem = $ - 2
            LD A,(HL)
            OR A
            JR NZ,scroller_text_continue
            LD HL,message
            LD A,(HL)
scroller_text_continue
            INC HL
            LD (ref_message_mem),HL
            SUB 0x40
            LD L,A
            LD H,0x00
            ADD HL,HL
            ADD HL,HL
            ADD HL,HL
            ADD HL,HL
            ADD HL,HL
            LD DE,font
            ADD HL,DE
            LD DE,scroller_buffer_mem + 0x20
            LD B,0x00
            LD A,0x10
scroller_copy_char
            LD C,0x22
            LDI
            LDI
            EX DE,HL
            ADD HL,BC
            EX DE,HL
            DEC A
            JP NZ,scroller_copy_char
            RET

message
    INCBIN "message.txt"
    db 0

font
    INCBIN "font.bin"
