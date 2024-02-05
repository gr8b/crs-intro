        DEVICE ZXSPECTRUM48

    MODULE masked_scroller

scroll_move_code = 0x8100
ref_scroll_lines_mem = 0x8000
shadow_screen_buffer = 0xe000

scroll
        ; scroll up, check new line
scroll_new_line
ref_scroll_new_line = $ + 1
        LD      A,0x80
        RLCA
        LD      (ref_scroll_new_line),A
        RET     NC
ref_scroll_message_mem = $ + 1
        LD      BC,message
        LD      DE,0x1111
ref_scroll_line_mem = $ - 1
scroll_new_line_copy_char
        LD      A,(BC)
        LD      L,A
        LD      H,0x1e
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
scroll_new_line_copy_char1
        LD      A,(HL)
        LD      (DE),A
        INC     L
        LD      A,E
        ADD     0x20
        LD      E,A
        JR      NC,scroll_new_line_copy_char1
        INC     BC
        INC     E
        SUB     0x1f
        JR      NZ,scroll_new_line_copy_char
        LD      A,(BC)
        OR      A
        JR      NZ,scroll_new_line_store_message_addr
        LD      BC,message
scroll_new_line_store_message_addr
        LD      (ref_scroll_message_mem),BC
        ret

init
        LD      HL,code_base
        LD      DE,scroll_move_code
        LD      BC,code2 - code1
        LDIR
        LD      IX,logo_and_mask
        LD      HL,code_base + (code3 - code1)
        LD      BC,code4 - code3
        LDIR
        LD      B,0x40
line_copy_code1
        PUSH    BC
        EX      DE,HL
        LD      B,0x10
line_copy_code2
        LD      (HL),0xc1                       ; POP BC
        INC     HL
        LD      (HL),0x71                       ; LD (HL),C
        CALL    process_gfx_byte
        LD      (HL),0x70                       ; LD (HL),B
        CALL    process_gfx_byte
        DJNZ    line_copy_code2
        DEC     DE
        EX      DE,HL
        LD      HL,code_base + (code2 - code1)
        LD      C,(code4 - code2)
        LDIR
        POP     BC
        DJNZ    line_copy_code1

        DEC     DE
        DEC     DE
        DEC     DE
        LD      A,0x40

        RET

function_6A54:
        INC     H
        LD      A,H
        AND     0x07
        RET     NZ
        OR      0x20
        ADD     A,L
        LD      L,A
        RET     C
        LD      A,H
        SUB     0x08
        LD      H,A
        RET

process_gfx_byte
        LD      E,(IX + 0x00)                   ; logo byte mask
        LD      A,(IX + 0x01)                   ; logo byte gfx
        OR      A
        JR      Z,process_gfx_empty_byte
        CP      E
        JR      Z,process_gfx_skip_mask
process_gfx_and_mask
        SET     3,(HL)                          ; LD (HL),C => LD A,C
                                                ; LD (HL),B => LD A,B
        INC     HL
        LD      (HL),0xe6                       ; AND xx
        INC     HL
        LD      (HL),E
        INC     HL
        OR      A
        JR      Z,process_gfx_skip_gfx
        LD      (HL),0xf6                       ; OR xx
        INC     HL
        LD      (HL),A
        INC     HL
process_gfx_skip_gfx
        LD      (HL),0x77                       ; LD (HL),A
process_gfx_end
        INC     HL
        LD      (HL),0x2c                       ; INC L
        INC     HL
        INC     IX
        INC     IX
        RET
process_gfx_empty_byte
        INC     E
        JR      Z,process_gfx_end
        DEC     E
        JR      process_gfx_and_mask
process_gfx_skip_mask
        LD      (HL),0x36                       ; LD (HL),xx
        INC     HL
        LD      (HL),A
        JR      process_gfx_end


code_base = $
   PHASE        scroll_move_code
code1
        LD      HL,shadow_screen_buffer
        EXX
ref_mem_position_l = $ + 1
        LD      HL,ref_scroll_lines_mem
        LD      A,L
        ADD     A,0x02
        LD      (ref_mem_position_l),A
code2
        INC     HL
        EXX
        EX      DE,HL
code3
        LD      E,(HL)
        INC     L
        LD      D,(HL)
        INC     L
        EX      DE,HL
        LD      SP,HL
        EXX
code4
     ENT


logo_and_mask
; logo 64 bytes per horizontal line. bytes order - mask1, gfx1, mask2, gfx2 ...
    INCBIN "logo.bin"

    ENDMODULE
