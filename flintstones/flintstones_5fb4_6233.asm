	CALL function_5FD9	;[function_5FD9]
	JR label_6009	;[label_6009]
label_5FB9:
	LD SP,$5FB3	;[data_5CF4 + 703]
	LD A,$07
	OUT ($FE),A
	LD A,$3F
	CALL function_5FDC	;[function_5FDC]
	LD B,$10
	CALL function_5FE8	;[function_5FE8]
	CALL function_61A8	;[function_61A8]
	LD B,$4F
	CALL function_5FE8	;[function_5FE8]
	CALL function_61A8	;[function_61A8]
	LD HL,$6867	;[label_6229 + 1598]
	PUSH HL
function_5FD9:
; 	SUB A
; 	OUT ($FE),A
; function_5FDC:
; 	LD HL,$5AFF	;[ScreenAttributes + 767]
; 	LD DE,$5AFE	;[ScreenAttributes + 766]
; 	LD B,$03
; 	LD (HL),A
; 	LDDR
	RET
function_5FE8:
	LD C,$05
	LD DE,(data_5CF4)	;[data_5CF4]
label_5FEE:
	LD HL,function_61A8	;[function_61A8]
	PUSH DE
	PUSH BC
	CALL function_5FFE	;[function_5FFE]
	POP BC
	POP DE
	INC (IY+$00)
	JR NZ,label_5FEE	;[label_5FEE]
	RET
function_5FFE:
	LD (IY+$00),$FF
	LD (data_5C3D),SP	;[data_5C3D]
	JP label_3D13	;[label_3D13]
label_6009:
	LD HL,$DF00	;[function_CBE5 + 4891]
	LD DE,$DF01	;[function_CBE5 + 4892]
	LD B,$21
	LD (HL),L
	LDIR
	LD HL,$7AA8	;[function_6A63 + 4165] logo.bin
	LD DE,$F100	;[function_CBE5 + 9499]
	LD BC,$01E8	;[TOKENS + 339]
	LDIR
	LD DE,function_C636	;[function_C636] music.bin
	LD BC,$18B2	;[OUT_LINE5 + 17]
	LDIR
	CALL function_C636	;[function_C636]
; 	DI
; 	LD A,$47
; 	LD (data_5C8D),A	;[data_5C8D]
; 	LD (data_5C48),A	;[data_5C48]
; 	CALL CLS	;[CLS]
; 	LD A,$02
; 	CALL CHAN_OPEN	;[CHAN_OPEN]
; 	LD HL,$69D5	;[label_6229 + 1964]
; label_603E:
; 	LD A,(HL)
; 	AND $7F
; 	RST $10	;[PRINT_A_1]
; 	BIT 7,(HL)
; 	INC HL
; 	JR Z,label_603E	;[label_603E]
; 	LD A,$FF
; 	LD HL,$4660	;[ScreenPixels + 1632]
; 	LD B,$20
; label_604E:
; 	LD (HL),A
; 	INC L
; 	DJNZ label_604E	;[label_604E]
; 	LD HL,$5180	;[ScreenPixels + 4480]
; 	LD B,$20
; label_6057:
; 	LD (HL),A
; 	INC L
; 	DJNZ label_6057	;[label_6057]
	INC A
	; LD C,$0D
	; LD HL,$6A99	;[function_6A63 + 54]
	; LD DE,label_8100	;[label_8100]
	; LDIR
	; LD H,D
	; LD L,E
	; LD C,$16
	; ADD HL,BC
	; LD (data_69F8),HL	;[data_69F8]
	; LD C,$1A
	; ADD HL,BC
	; LD (data_69FC),HL	;[data_69FC]
	; LD HL,$69F6	;[label_6229 + 1997]
	; LD C,$08
	; LDIR
	; LD C,$34
	; LDIR
	; LD HL,$6A32	;[data_6A26 + 12]
	; LD C,$15
	; LDIR
	; PUSH DE
	; LD H,D
	; LD L,E
	; LD C,$08
	; SBC HL,BC
	; LD B,H
	; LD C,L
	; LD (data_8101),HL	;[data_8101]
	; POP HL
	; DEC HL
	; LD (HL),B
	; DEC HL
	; LD (HL),C
	; LD C,A
; 	LD IX,$6AA8	;[function_6A63 + 69]
; 	LD B,$40
; label_609E:
; 	LD HL,$6AA1	;[function_6A63 + 62]
; 	PUSH BC
; 	LD B,C
; 	LD C,$07
; 	LDIR
; 	EX DE,HL
; 	LD B,$10
; label_60AA:
; 	LD (HL),$C1
; 	INC HL
; 	LD A,$71
; 	CALL function_6A63	;[function_6A63]
; 	LD A,$70
; 	CALL function_6A63	;[function_6A63]
; 	DJNZ label_60AA	;[label_60AA]
; 	DEC HL
; 	LD (HL),$23
; 	INC HL
; 	LD (HL),$D9
; 	INC HL
; 	LD (HL),$EB
; 	INC HL
; 	POP BC
; 	EX DE,HL
; 	DJNZ label_609E	;[label_609E]
	DEC DE
	DEC DE
	DEC DE
	LD A,$40
/* useless code
	LD HL,$E000	;[function_CBE5 + 5147]
	LD (data_69FF),HL	;[data_69FF]
	LD L,$10
	LD (data_6A19),HL	;[data_6A19]
	LD HL,$4090	;[ScreenPixels + 144]
	LD (data_6A0C),HL	;[data_6A0C]
	LD L,$A0
	LD (data_6A26),HL	;[data_6A26]
*/
label_60E2:
	EX AF,AF'
	LD HL,$69FE	;[data_69FC + 2]
	LD C,$34
	LDIR
	LD HL,(data_6A0C)	;[data_6A0C]
	CALL function_6A54	;[function_6A54]
	LD (data_6A0C),HL	;[data_6A0C]
	LD C,$10
	ADD HL,BC
	LD (data_6A26),HL	;[data_6A26]
	LD HL,(data_69FF)	;[data_69FF]
	ADD HL,BC
	ADD HL,BC
	LD (data_69FF),HL	;[data_69FF]
	ADD HL,BC
	LD (data_6A19),HL	;[data_6A19]
	EX AF,AF'
	DEC A
	JR NZ,label_60E2	;[label_60E2]
	LD HL,$4880	;[ScreenPixels + 2176]
	LD (data_69FF),HL	;[data_69FF]
	LD L,$90
	LD (data_6A19),HL	;[data_6A19]
	LD A,$40
label_6116:
	EX AF,AF'
	LD HL,(data_6A19)	;[data_6A19]
	LD C,$10
	ADD HL,BC
	LD (data_6A26),HL	;[data_6A26]
	LD HL,(data_69FF)	;[data_69FF]
	PUSH HL
	ADD HL,BC
	LD (data_6A0C),HL	;[data_6A0C]
	POP HL
	CALL function_6A54	;[function_6A54]
	LD (data_69FF),HL	;[data_69FF]
	ADD HL,BC
	LD (data_6A19),HL	;[data_6A19]
	LD HL,$69FE	;[data_69FC + 2]
	LD C,$34
	LDIR
	EX AF,AF'
	DEC A
	JR NZ,label_6116	;[label_6116]
	LD HL,$DF00	;[function_CBE5 + 4891]
	LD (data_69FF),HL	;[data_69FF]
	LD (data_6A19),HL	;[data_6A19]
	LD H,D
	LD L,E
	INC HL
	LD (data_6A48),HL	;[data_6A48]
	LD (data_6A4D),HL	;[data_6A4D]
	LD C,$1A
	ADD HL,BC
	LD (data_6A52),HL	;[data_6A52]
	LD HL,$69FE	;[data_69FC + 2]
	LD C,$34
	LDIR
	LD HL,$6A47	;[data_6A26 + 33]
	LD C,$0D
	LDIR
	EX DE,HL
	LD (HL),$C3
	INC HL
	LD (HL),$9A
	INC HL
	LD (HL),$61
	LD HL,$8000	;[function_6A63 + 5533]
	LD DE,$E800	;[function_CBE5 + 7195]
	LD B,$40
label_6175:
	LD (HL),E
	INC L
	LD (HL),D
	INC L
	LD A,E
	ADD A,$20
	LD E,A
	ADC A,D
	SUB E
	LD D,A
	DJNZ label_6175	;[label_6175]
	LD D,H
	LD E,L
	LD L,B
	LD C,$80
	LDIR
	LD HL,$FE00	;[function_CBE5 + 12827]
	LD A,H
	LD I,A
	INC A
label_6190:
	LD (HL),A
	INC HL
	DJNZ label_6190	;[label_6190]
	LD (HL),A
	LD L,A
	LD (HL),$C9
	IM 2

	LD A,$01
data_619B:
	RRCA
	LD (data_619B),A	;[data_619B]
	JP NC,label_61CD	;[label_61CD]
	LD BC,$6234	;[label_6229 + 11]
data_61A4:
	LD DE,$DF00	;[function_CBE5 + 4891]
function_61A8:
label_61A9:
	LD A,(BC)
	LD L,A
	LD H,$1E
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
label_61B0:
	LD A,(HL)
	LD (DE),A
	INC L
	LD A,E
	ADD A,$20
	LD E,A
	JP NC,label_61B0	;[label_61B0]
	INC BC
	INC E
	SUB $1F
	JP NZ,label_61A9	;[label_61A9]
	LD A,(BC)
	OR A
	JP NZ,label_61C9	;[label_61C9]
	LD BC,$6234	;[label_6229 + 11]
label_61C9:
	LD (data_61A4),BC	;[data_61A4]
label_61CD:
	LD SP,$FFFF	;[function_CBE5 + 13338]
	CALL function_CBE5	;[function_CBE5]
	LD A,$C9
	LD (data_CB74),A	;[data_CB74]
	CALL function_CBE5	;[function_CBE5]
	LD A,$20
	LD (data_CB74),A	;[data_CB74]
	LD DE,$F00E	;[function_CBE5 + 9257]
	LD BC,$000E	;[ERROR_1 + 6]
	LDDR
	LD A,$BF
	IN A,($FE)
	RRA
	JR NC,label_6201	;[label_6201]
	LD C,$10
	LD A,$7F
	IN A,($FE)
	RRA
	JP C,label_8100	;[label_8100]
	IM 1
	CALL function_C636	;[function_C636]
	JP label_5FB9	;[label_5FB9]
label_6201:
	EI
	HALT
	CALL function_6216	;[function_6216]
label_6206:
	EI
	HALT
	CALL function_CBE5	;[function_CBE5]
	LD A,$BF
	IN A,($FE)
	RRA
	JR NC,label_6206	;[label_6206]
	EI
	HALT
	JR label_61CD	;[label_61CD]
function_6216:
	LD HL,$F00E	;[function_CBE5 + 9257]
	LD DE,$FFBF	;[function_CBE5 + 13274]
	LD C,$FD
	XOR A
	OR (HL)
	LD A,$0D
	JR NZ,label_6229	;[label_6229]
	SUB $03
	DEC HL
	DEC HL
	DEC HL
label_6229:
	LD B,D
	OUT (C),A
	LD B,E
	OUTD
	DEC A
	JP P,label_6229	;[label_6229]
	RET
