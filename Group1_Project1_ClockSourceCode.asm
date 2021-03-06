ORG 00H
MOV DPTR, #MYDATA

START:
	MOV R0, #00H
	MOV R1, #00H
	MOV R2, #00H
	MOV R3, #00H
	MOV R4, #00H
	MOV R5, #00H

DISPLAY:

	ACALL SHOW

BACK:

	INC R0
	CJNE R0, #10D, DISPLAY
	MOV R0,  #00H

	INC R1
	CJNE R1, #6D, DISPLAY
	MOV R1,  #00H

	INC R2
	CJNE R2, #10D, DISPLAY
	MOV R2,  #00H

	INC R3
	CJNE R3, #6D, DISPLAY
	MOV R3,  #00H

	CLR C 
	MOV A, R5
	SUBB A,#2D
	JZ LEVEL1

	INC R4
	CJNE R4, #10D, DISPLAY
	MOV R4,  #00H
	SJMP LEVEL0

LEVEL1:

	INC R4
	CJNE R4, #4D, DISPLAY
	MOV R4,  #00H

LEVEL0: 

	INC R5
	CJNE R5, #3D, DISPLAY
	MOV R5,  #00H
	SJMP START

SHOW:

	CLR P2.2
	CLR P2.3
	CLR P2.4
	CLR P2.5

	MOV R6, #65D

REPEAT:

	MOV A, R0       ; MC = 1 
	MOVC A, @A+DPTR ; MC = 2
	SETB P2.0       ; MC = 1
	MOV P1, A       ; MC = 1
	ACALL DELAY     ; MC = 2 
	CLR P2.0        ; MC = 1
	
	MOV A, R1
	MOVC A, @A+DPTR
	SETB P2.1
	MOV P1, A
	ACALL DELAY
	CLR P2.1
	
	MOV A, R2
	MOVC A, @A+DPTR
	SETB P2.2
	MOV P1, A
	ACALL DELAY
	CLR P2.2
	
	MOV A, R3
	MOVC A, @A+DPTR
	SETB P2.3
	MOV P1, A
	ACALL DELAY
	CLR P2.3
	
	MOV A, R4
	MOVC A, @A+DPTR
	SETB P2.4
	MOV P1, A
	ACALL DELAY
	CLR P2.4
	
	MOV A, R5
	MOVC A, @A+DPTR
	SETB P2.5
	MOV P1, A
	ACALL DELAY
	CLR P2.5
	
	DJNZ R6, REPEAT ; MC = 2
	RET ; MC = 2

DELAY:
	SETB PSW.4   ; MC = 1
	MOV R2,#10   ; MC = 1
AGAIN2: MOV R3,#100  ; MC = 1
AGAIN1: DJNZ R3, AGAIN1 ; MC = 2
	DJNZ R2, AGAIN2 ; MC = 2
	CLR PSW.4    ; MC = 1
	RET          ; MC = 2

ORG 300H
MYDATA: DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH
END