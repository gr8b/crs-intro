function_6A63:
	LD (HL),A
	LD E,(IX+$00)
	LD A,(IX+$01)
	OR A
	JR Z,label_6A8D	;[label_6A8D]
	CP (IX+$00)
	JR Z,label_6A93	;[label_6A93]
label_6A72:
	SET 3,(HL)
	INC HL
	LD (HL),$E6
	INC HL
	LD (HL),E
	INC HL
	OR A
	JR Z,label_6A82	;[label_6A82]
	LD (HL),$F6
	INC HL
	LD (HL),A
	INC HL
label_6A82:
	LD (HL),$77
label_6A84:
	INC HL
	LD (HL),$2C
	INC HL
	INC IX
	INC IX
	RET
label_6A8D:
	INC E
	JR Z,label_6A84	;[label_6A84]
	DEC E
	JR label_6A72	;[label_6A72]
label_6A93:
	LD (HL),$36
	INC HL
	LD (HL),A
	JR label_6A84	;[label_6A84]
	LD A,(data_3A3A)	;[data_3A3A]
	LD H,$80
	ADD A,$7E
	LD L,A
	LD E,(HL)
	INC L
	LD D,(HL)
	INC L
	EX DE,HL
	LD SP,HL
	EXX
