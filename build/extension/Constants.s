; Library_Digest loads Constants.s and creates two ascii files:
;	Constants_Size.s contains the number of functions in the extension
;	Constants_Labels.s contains the list of labels and their value.

; Genam FROM Constants.s TO dh0:AMOSPro.s/2.10/APSystem/FxBox_Constants.Lib

ExtNb		equ	8-1

		Include	"Constants_Size.s"
		Include	"Constants_Labels.s"
		Include	"+AMOS_Includes.s"

Version    MACRO
           dc.b "1.00",0
           ENDM
VerNumber  equ $100


; find the address of data in the extension's own datazone...
Dlea		MACRO
		move.l	ExtAdr+ExtNb*16(a5),\2
		add.w	#\1-MB,\2
		ENDM

; load the base address of the datazone...
Dload		MACRO
		move.l	ExtAdr+ExtNb*16(a5),\1
		ENDM

; pointer to the token list
Start	dc.l	C_Tk-C_Off
		dc.l	C_Lib-C_Tk
		dc.l	C_Title-C_Lib
		dc.l	C_End-C_Title
		dc.w	0
		dc.b	"AP20"

		MCInit
C_Off
		REPT	Lib_Size
		MC
		ENDR

;	Library_Digest uses this to detect the start of the tokens.
;	TOKEN_START

C_Tk
	dc.w 	1,0
	dc.b 	$80,-1
	dc.w	L_Nul,L_FnLocalhost
	dc.b	"localhost","$"+$80,"2",-1
	dc.w	L_Nul,L_FnDosLibrary
	dc.b	"dos library","$"+$80,"2",-1
	dc.w	L_Nul,L_FnBsdSocketLibrary
	dc.b	"bsd socket library","$"+$80,"2",-1
	dc.w	L_Nul,L_FnMathTransLibrary
	dc.b	"math trans library","$"+$80,"2",-1
	dc.w	L_Nul,L_FnOk
	dc.b	"ok","$"+$80,"2",-1
	dc.w	L_Nul,L_FnCancel
	dc.b	"cancel","$"+$80,"2",-1
	dc.w	L_Nul,L_FnUnnamed
	dc.b	"unnamed","$"+$80,"2",-1
	dc.w	L_Nul,L_FnPalClock
	dc.b	"pal cloc","k"+$80,"0",-1
	dc.w	L_Nul,L_FnNtscClock
	dc.b	"ntsc cloc","k"+$80,"0",-1
	dc.w	L_Nul,L_FnBack
	dc.b	"bac","k"+$80,"0",-1
	dc.w	L_Nul,L_FnPane
	dc.b	"pan","e"+$80,"0",-1
	dc.w	L_Nul,L_FnWhite
	dc.b	"whit","e"+$80,"0",-1
	dc.w	L_Nul,L_FnGray
	dc.b	"gra","y"+$80,"0",-1
	dc.w	L_Nul,L_FnBlack
	dc.b	"blac","k"+$80,"0",-1
	dc.w	L_Nul,L_FnShadow
	dc.b	"shado","w"+$80,"0",-1
	dc.w	L_Nul,L_FnBright
	dc.b	"brigh","t"+$80,"0",-1
	dc.w	L_Nul,L_FnHighlight
	dc.b	"highligh","t"+$80,"0",-1
	dc.w	L_Nul,L_FnGreen
	dc.b	"gree","n"+$80,"0",-1
	dc.w	L_Nul,L_FnDarkGreen
	dc.b	"dark gree","n"+$80,"0",-1
	dc.w	L_Nul,L_FnBrown
	dc.b	"brow","n"+$80,"0",-1
	dc.w	L_Nul,L_FnBeige
	dc.b	"beig","e"+$80,"0",-1
	dc.w	L_Nul,L_FnRed
	dc.b	"re","d"+$80,"0",-1
	dc.w	L_Nul,L_FnDarkBlue
	dc.b	"dark blu","e"+$80,"0",-1
	dc.w	L_Nul,L_FnLightBlue
	dc.b	"light blu","e"+$80,"0",-1
	dc.w	L_Nul,L_FnBlue
	dc.b	"blue","e"+$80,"0",-1

;	TOKEN_END

	dc.w 	0
	dc.l	0

	Lib_Ini	0

C_Lib

;	COLD START

	Lib_Def	Cold

;	movem.l	a3-a6,-(sp)

; Here I store the address of the extension data zone in the special area
	lea	MB(pc),a3
	move.l	a3,ExtAdr+ExtNb*16(a5)

; As you can see, you MUST preserve A3-A6, and return in D0 the 
; Number of the extension if everything went allright. If an error has
; occured (no more memory, no file found etc...), return -1 in D0 and
; AMOS will refuse to start.

;	movem.l	(sp)+,a3-a6

	moveq	#ExtNb,d0		* NO ERRORS
	move.w	#VerNumber,d1		* Version d'ecriture
 	rts

; - - - - - - - - - - - - -
MB:
_lh
	dc.b	0,9,"127.0.0.1"
_dl	
	dc.b	0,11,"dos.library"
_bsd
	dc.b	0,17,"bsdsocket.library"
_mt
	dc.b	0,17,"mathtrans.library"
_o
	dc.b	0,2,"Ok"
_c
	dc.b	0,6,"Cancel"
_u
	dc.b	0,9,"<unnamed>"
	even
; - - - - - - - - - - - - -
	Lib_Empty

; - - - - - - - - - - - - -
	Lib_Par	FnLocalhost	

	Dlea	_lh,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnDosLibrary	

	Dlea	_dl,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnBsdSocketLibrary	

	Dlea	_bsd,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnMathTransLibrary	

	Dlea	_mt,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnOk	

	Dlea	_o,a0
	move.l	a0,d3
	Ret_String
	
; - - - - - - - - - - - - -
	Lib_Par	FnCancel	

	Dlea	_c,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnUnnamed	

	Dlea	_u,a0
	move.l	a0,d3
	Ret_String

; - - - - - - - - - - - - -
	Lib_Par	FnPalClock	

	move.l	#3546895,d3
	Ret_Int

; - - - - - - - - - - - - -
	Lib_Par	FnNtscClock	

	move.l	#3579545,d3
	Ret_Int

; - - - - - - - - - - - - -
	Lib_Par	FnBack	

	move.l	#0,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnPane	

	move.l	#1,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnWhite	

	move.l	#2,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnGray	

	move.l	#3,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnBlack	

	move.l	#4,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnShadow	

	move.l	#5,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnBright	

	move.l	#6,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnHighlight	

	move.l	#7,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnGreen	

	move.l	#8,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnDarkGreen	

	move.l	#9,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnBrown	

	move.l	#10,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnBeige	

	move.l	#11,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnRed	

	move.l	#12,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnDarkBlue	

	move.l	#13,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnLightBlue	

	move.l	#14,d3
	Ret_Int
	; - - - - - - - - - - - - -
	Lib_Par	FnBlue	

	move.l	#15,d3
	Ret_Int
	
; - - - - - - - - - - - - -
	Lib_Empty
	Lib_Empty

; - - - - - - - - - - - - -
	Lib_End

; - - - - - - - - - - - - -
C_Title	dc.b	"FxBox Constants Extension V "
	Version
	dc.b	0,"$VER: "
	Version
	dc.b	0
	Even
C_End	dc.w	0
	even