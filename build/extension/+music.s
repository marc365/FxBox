; ______________________________________________________________________________
; ..............................................................................
; ...................................................................2222222....
; ................................................................22222222220...
; ...................................................222........222222.....222..
; ..............................................2202222222222..22000............
; ..................................22000.....20222222222200000200002...........
; .................................2002202...2222200222.220000000200000000022...
; ....................220002......22222200..2200002.......2200000...20000000000.
; ....................22222202....2220000022200000..........200002........200000
; .....200000.........2222200000222200220000000002..........200002........20000.
; .....00222202........2220022000000002200002000002........2000002000020000000..
; ....2222200000.......220002200000002.2000000000000222222000000..2000000002....
; ....220000200002......20000..200002..220000200000000000000002.......22........
; ...2220002.220000 2....220002...22.....200002..0000000000002...................
; ...220000..222000002...20000..........200000......2222........................
; ...000000000000000000..200000..........00002..................................
; ..220000000022020000002.200002.........22.......______________________________
; ..0000002........2000000220022.................|
; .200000............2002........................| marc365 dec 2025
; .200002........................................| music extension replacement
; 220002.........................................|______________________________
; ______________________________________________________________________________
; 
ExtNb		equ	1-1

		Include	"+Music_Size.s"
		Include	"+Music_Labels.s"

		Include	"+AMOS_Includes.s"
		Include	"+Version.s"

Dlea		MACRO
		move.l	ExtAdr+ExtNb*16(a5),\2
		add.w	#\1-MB,\2
		ENDM

Dload		MACRO
		move.l	ExtAdr+ExtNb*16(a5),\1
		ENDM

IntEnaR		equ	$1c
IntReqR		equ	$1e
is_data		equ	$0e
is_code		equ	$12
ln_pri		equ	$09
ln_type		equ	$08

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

C_Tk:	dc.w 	1,0
	dc.b 	$80,-1

	; functions with a * are removed, the token is kept for combatibility
	dc.w	L_Nul,L_NullPar						*
	dc.b	"mubas","e"+$80,"0",-1
	dc.w	L_Nul,L_NullPar						*
	dc.b	"vumete","r"+$80,"00",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"voic","e"+$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"music of","f"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"music sto","p"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"temp","o"+$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"musi","c"+$80,"I0",-1

	dc.w	L_NullPar,L_Nul						*
	dc.b	"noise t","o"+$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b 	"boo","m"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"shoo","t"+$80,"I",-1
	dc.w	L_InSamBank,L_Nul
	dc.b	"sam ban","k"+$80,"I0",-1
	dc.w	L_InSamLoopOn0,L_Nul
	dc.b	"!sam loop o","n"+$80,"I",-2
	dc.w	L_InSamLoopOn1,L_Nul
	dc.b	$80,"I",-1
	dc.w	L_InSamLoopOff0,L_Nul
	dc.b	"sam loop of","f"+$80,"I",-2
	dc.w	L_InSamLoopOff1,L_Nul
	dc.b	$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"sampl","e"+$80,"I0t0",-1
	dc.w 	L_InSamPlay1,L_Nul
	dc.b 	"!sam pla","y"+$80,"I0",-2
	dc.w	L_InSamPlay2,L_Nul
	dc.b	$80,"I0,0",-2
	dc.w 	L_InSamPlay3,L_Nul
	dc.b	$80,"I0,0,0",-1 
	dc.w 	L_InSamRaw,L_Nul
	dc.b 	"sam ra","w"+$80,"I0,0,0,0",-1	
	dc.w	L_NullPar,L_Nul						*
	dc.b 	"!bel","l"+$80,"I",-2
	dc.w 	L_NullPar,L_Nul						*
	dc.b	$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"!play of","f"+$80,"I",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0",-1
	dc.w 	L_NullPar,L_Nul						*
	dc.b	"!pla","y"+$80,"I0,0",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0,0,0",-1
	dc.w 	L_NullPar,L_Nul						*
	dc.b 	"set wav","e"+$80,"I0,2",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"del wav","e"+$80,"I0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"set enve","l"+$80,"I0,0t0,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"mvolum","e"+$80,"I0",-1
	dc.w 	L_InVolume1,L_Nul						*
	dc.b	"!volum","e"+$80,"I0",-2
	dc.w 	L_InVolume2,L_Nul						*
	dc.b	$80,"I0,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b 	"wav","e"+$80,"I0t0",-1
	dc.w	L_InLedOn,L_Nul
	dc.b	"led o","n"+$80,"I",-1
	dc.w	L_InLedOf,L_Nul
	dc.b	"led of","f"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"!sa","y"+$80,"I2",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I2,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"set tal","k"+$80,"I0,0,0,0",-1
	dc.w	L_InSload,L_Nul
	dc.b	"sloa","d"+$80,"I0t0,0",-1
	dc.w	L_Nul,L_FnSamSwapped
	dc.b	"sam swappe","d"+$80,"00",-1
	dc.w	L_InSamSwap,L_Nul
	dc.b	"sam swa","p"+$80,"I0t0,0",-1
	dc.w 	L_InSamStop0,L_Nul
	dc.b	"!sam sto","p"+$80,"I",-2
	dc.w	L_InSamStop1,L_Nul
	dc.b	$80,"I0",-1

	dc.w	L_NullPar,L_Nul						*
	dc.b	"track sto","p"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"track loop o","n"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"track loop o","f"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"!track pla","y"+$80,"I",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"track loa","d"+$80,"I2,0",-1
	
	dc.w	L_Nul,L_NullPar						*
	dc.b	"mouth widt","h"+$80,"0",-1
	dc.w	L_Nul,L_NullPar						*
	dc.b	"mouth heigh","t"+$80,"0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"mouth rea","d"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"talk sto","p"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"talk mis","c"+$80,"I0,0",-1

	dc.w	L_InSsave,L_Nul
	dc.b	"ssav","e"+$80,"I0,0t0",-1

	dc.w	L_NullPar,L_Nul						*
	dc.b	"med loa","d"+$80,"I2,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"!med pla","y"+$80,"I",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0",-2
	dc.w	L_NullPar,L_Nul						*
	dc.b	$80,"I0,0",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"med sto","p"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"med con","t"+$80,"I",-1
	dc.w	L_NullPar,L_Nul						*
	dc.b	"med midi o","n"+$80,"I",-1

	dc.w 	0
	dc.l	0

	Lib_Ini	0

C_Lib

; - - - - - - - - - - - - -
	Lib_Def	Ext_Cold		
; - - - - - - - - - - - - -
	
	cmp.l	#"APex",d1		Version 1.10 or over?
	bne.s	BadVer

	movem.l	a3-a6,-(sp)
	lea	MB(pc),a3
	move.l	a3,ExtAdr+ExtNb*16(a5)
	lea	ExtDef(pc),a0
	move.l	a0,ExtAdr+ExtNb*16+4(a5)
	lea	ExtEnd(pc),a0
	move.l	a0,ExtAdr+ExtNb*16+8(a5)

	EcCall	NTSC			* Is system NTSC?
	tst.w	d1
	beq.s	ItsPAL
	move.l	#3579545,MusClock-MB(a3)
ItsPAL	
	lea	Sami_handler(pc),a0
	move.l	a0,Sami_handad-MB(a3)
	movem.l	(sp)+,a3-a6
	moveq	#ExtNb,d0		* NO ERRORS
	move.w	#$0110,d1		* Version d'ecriture
 	rts
BadVer	moveq	#-1,d0			* Bad version number
	sub.l	a0,a0
	rts

ExtDef	Dload	a3	
	move.w	#$000F,Circuits+DmaCon
	Rbsr	L_Sami_install
	moveq	#64,d0			* Default settings
	moveq	#%1111,d1
	Rbsr	L_Vol
	move.w	#5,SamBank-MB(a3)	* Sample bank=5	
	moveq	#-1,d0			* Sam loop off
	moveq	#-1,d1
	Rbra	L_SL0

ExtEnd:	Dload	a3
	Rbsr	L_Sami_remove
	lea	Circuits,a0
	move.w	#$000F,DmaCon(a0)
	clr.w	$a8(a0)
	clr.w	$b8(a0)
	clr.w	$c8(a0)
	clr.w	$d8(a0)
	rts

***********************************************************
*
*	INTERRUPT ROUTINES
*
***********************************************************	

******* Sami interrupt handlers
Sami_handler
	add.w	Sami_reg(a1),a0
	move.l	Sami_pos(a1),d0
	cmp.l	Sami_long(a1),d0
	bcc.s	.whatnow
* Poursuit la lecture du sample
.samloop
	move.l	d0,d1
	add.l	#Sami_lplay,d1
	cmp.l	Sami_long(a1),d1
	bls.s	.skip
	move.l	Sami_long(a1),d1
.skip	move.l	d1,Sami_pos(a1)
	sub.l	d0,d1
	lsr.l	#1,d1
	add.l	Sami_adr(a1),d0
	move.l	d0,(a0)				* AUDxLOC
	move.w	d1,4(a0)			* AUDxLEN
	move.w	Sami_dvol(a1),d0
	bmi.s	.skip1
	move.w	d0,8(a0)			* AUDxVOL
.skip1	move.w	Sami_bit(a1),Circuits+IntReq
	rts
* Sample termine. Que faire?
.whatnow
	move.l	d0,d1
	move.l	Sami_radr(a1),d0		* Double buffer?
	bne.s	.swap
	move.l	Sami_rpos(a1),d0		* Boucler?
	bpl.s	.samloop
	bset	#7,Sami_pos(a1)			* Attend?
	tst.l	d1
	bpl.s	.skip1
* Fin du sample-> met du blanc!
	move.w	#0,$a(a0)
	move.w	Sami_dma(a1),d0
	moveq	#0,d1
	bset	d0,d1
	move.w	d1,Circuits+DmaCon
	move.w	Sami_bit(a1),Circuits+IntEna	* No more interrupts
	move.w	Sami_bit(a1),Circuits+IntReq
	rts
* Change de buffer
.swap	clr.l	Sami_radr(a1)
	move.l	d0,Sami_adr(a1)
	move.l	Sami_rlong(a1),Sami_long(a1)
	moveq	#0,d0
	bra	.samloop


*********************************************************************
*		MUSIC extension data zone

;editor is hardcoded to this branch with
;move.l	ExtAdr(a5),d0
;jsr -4(a0)

; Branches for AMOSPro Editor (-4)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		Rbra	L_GoSam

MB:
MusClock	dc.l 	3546895
SamBank:	dc.w 	0

*************** SAMPLE PLAYER INTERRUPT STRUCTURES
Sami_lplay	equ	1024*4
Sami_bit	equ	22
Sami_dma	equ	24
Sami_reg	equ	26
Sami_adr	equ	28
Sami_long	equ	32
Sami_pos	equ	36
Sami_rpos	equ	40
Sami_radr	equ	44
Sami_rlong	equ	48
Sami_dvol	equ	52
Sami_old	equ	54
Sami_intl	equ	58

Sami_int	ds.b	22				* Channel 0
		dc.w	%0000000010000000	bit
		dc.w	0			dma
		dc.w	$a0			reg
		dc.l	0			adr
		dc.l	0			long
		dc.l	0			pos
		dc.l	0			rpos
		dc.l	0			radr
		dc.l	0			rlong
		dc.w	0			dvol
		dc.l	0			old			

		ds.b	22				* Channel 1
		dc.w	%0000000100000000	bit
		dc.w	1			dma
		dc.w	$b0			reg
		dc.l	0			adr
		dc.l	0			long
		dc.l	0			pos
		dc.l	0			rpos
		dc.l	0			radr
		dc.l	0			rlong
		dc.w	0			dvol
		dc.l	0			old			

		ds.b	22				* Channel 2
		dc.w	%0000001000000000	bit
		dc.w	2			dma
		dc.w	$c0			reg
		dc.l	0			adr
		dc.l	0			long
		dc.l	0			pos
		dc.l	0			rpos
		dc.l	0			radr
		dc.l	0			rlong
		dc.w	0			dvol
		dc.l	0			old			

		ds.b	22				* Channel 3
		dc.w	%0000010000000000	bit
		dc.w	3			dma
		dc.w	$d0			reg
		dc.l	0			adr
		dc.l	0			long
		dc.l	0			pos
		dc.l	0			rpos
		dc.l	0			radr
		dc.l	0			rlong
		dc.w	0			dvol
		dc.l	0			old			

Sami_oldena	dc.w	0
Sami_bits	dc.w	0
Sami_handad	dc.l	0
Sami_flag	dc.w	0
SamLoops	dc.w	0


; - - - - - - - - - - - - -
	Lib_Empty		
; - - - - - - - - - - - - -
	

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; 					MUSIC INSTRUCTIONS
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	VOLUME n
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InVolume1	
; - - - - - - - - - - - - -
	move.l	d3,d0
	moveq	#%1111,d1
	Rbra	L_Vol

; - - - - - - - - - - - - -
	Lib_Par	InVolume2		
; - - - - - - - - - - - - -
	move.l	d3,d0
	move.l	(a3)+,d1
	Rbra	L_Vol

; - - - - - - - - - - - - -
	Lib_Def	Vol		
; - - - - - - - - - - - - -
	cmp.l	#65,d0		Set voices volume level
	Rbcc	L_IFonc
	moveq	#0,d2
	Dlea	Sami_int,a1
Vol1	btst	d2,d1
	beq.s	Vol2
	move.w	d0,Sami_dvol(a1)
Vol2
	lea	Sami_intl(a1),a1
	addq.w	#1,d2
	cmp.w	#4,d2
	bcs.s	Vol1
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	STOP DMA / INTERUPTS
;	D0= value
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	StopDma
; - - - - - - - - - - - - -
	move.w	d0,-(sp)
	eor.w	#%1111,d0
	move.w	d0,Circuits+DmaCon
	lsl.w	#7,d0
	move.w	d0,Circuits+IntEna
	move.w	(sp)+,d0
	Rbra	L_DmaWait
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	Wait for the DMA
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	DmaWait	
; - - - - - - - - - - - - -
	movem.l	d2-d3,-(sp)
.wait	moveq	#4,d3		
.wai2	move.b	$dff006,d2	
.wai3	cmp.b	$dff006,d2	
	beq.s	.wai3
	dbf	d3,.wai2	
	moveq	#8,d2
.wai4	dbf	d2,.wai4

	movem.l	(sp)+,d2-d3
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; 					SAMPLE INSTRUCTIONS
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAM BANK n
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamBank	
; - - - - - - - - - - - - -
	move.l	d3,d0
	Rbls	L_IFonc
	cmp.l	#16,d0
	Rbhi	L_IFonc
	Dlea	SamBank,a0
	move.w	d0,(a0)
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAMLOOP ON
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamLoopOn1	
; - - - - - - - - - - - - -
	moveq	#0,d0
	move.l	d3,d1
	Rbra	L_SL0
; - - - - - - - - - - - - -
	Lib_Par InSamLoopOn0	
; - - - - - - - - - - - - -
	moveq	#0,d0
	moveq	#%1111,d1
	Rbra	L_SL0


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAMLOOP OFF
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par InSamLoopOff1	
; - - - - - - - - - - - - -
	moveq	#-1,d0
	move.l	d3,d1
	Rbra	L_SL0
; - - - - - - - - - - - - -
	Lib_Par InSamLoopOff0	
; - - - - - - - - - - - - -
	moveq	#-1,d0
	moveq	#%1111,d1
	Rbra	L_SL0
; - - - - - - - - - - - - -
	Lib_Def	SL0		
; - - - - - - - - - - - - -
	moveq	#0,d2
	Dlea	Sami_int,a0
	Dlea	SamLoops+1,a1
Sl1	btst	d2,d1
	beq.s	Sl2
	bclr	d2,(a1)
	move.l	d0,Sami_rpos(a0)
	bne.s	Sl2
	bset	d2,(a1)
Sl2	lea	Sami_intl(a0),a0
	addq.w	#1,d2
	cmp.w	#4,d2
	bcs.s	Sl1
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAM PLAY [voice],number,[frequency]
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamPlay1		
; - - - - - - - - - - - - -
	move.l	d3,d0
	Rbsr	L_GetSam
	moveq	#%1111,d1
	Rbra	L_GoSam
; - - - - - - - - - - - - -
	Lib_Par	InSamPlay2		
; - - - - - - - - - - - - -
	move.l	d3,d0
	Rbsr	L_GetSam
	move.l	(a3)+,d1
	Rbra	L_GoSam
; - - - - - - - - - - - - -
	Lib_Par InSamPlay3		
; - - - - - - - - - - - - -
	move.l	d3,-(a3)
	move.l	4(a3),d0
	Rbsr	L_GetSam
	move.l	(a3)+,d3
	cmp.l	#500,d3
	Rble	L_IFonc
	addq.l	#4,a3
	move.l	(a3)+,d1	
	Rbra	L_GoSam


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAM RAW voice,ad,length,freq
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamRaw		
; - - - - - - - - - - - - -
	cmp.l	#500,d3
	Rble	L_IFonc
	move.l	(a3)+,d2
	cmp.l	#256,d2
	Rble	L_IFonc
	move.l	(a3)+,a1
	move.l	(a3)+,d1
	Rbra	L_GoSam
; - - - - - - - - - - - - -
	Lib_Def	GoSam
; - - - - - - - - - - - - -
	move.l	a3,-(sp)
	Dload	a3
	Rjsr	L_SaveRegs

	move.w	d1,d0
	eor.w	#$000F,d0
	Rbsr	L_StopDma

	lea	Circuits,a2
	move.w	#$8000,Sami_bits-MB(a3)
* Do all voices
	moveq	#0,d0
	move.w	d1,d4
	moveq	#3,d1
ISp2b	btst	d1,d4
	beq.s	ISp2c
	Rbsr	L_SPlay
ISp2c	dbra	d1,ISp2b
* Start!
ISpX	
	Rbsr	L_DmaWait
	bset	#15,d0
	move.w	d0,DmaCon(a2)
	move.w	Sami_bits-MB(a3),IntEna(a2)

	Rjsr	L_LoadRegs
	move.l	(sp)+,a3
	rts
	

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; 	Find a sample -> A0
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	GetSam	
; - - - - - - - - - - - - -
	move.l	d0,-(sp)
	Dload	a0
	move.w	SamBank-MB(a0),d0
	ext.l	d0
	Rbeq	L_IFonc
	move.l	d1,-(sp)
	Rjsr	L_Bnk.GetAdr
	Rbeq	L_BNSam
	move.l	(sp)+,d1
	move.l	-8(a0),d0
	cmp.l	#"Samp",d0
	Rbne	L_BNSam
; Get sample characteristics
	move.l	(sp)+,d0
	Rbls	L_IFonc
	cmp.w	(a0),d0
	Rbhi	L_SNDef
	lsl.w	#2,d0
	move.l	2-4(a0,d0.w),d0
	Rbeq	L_SNDef
	add.l	d0,a0
	moveq	#0,d3
	move.w	8(a0),d3
	move.l	10(a0),d2
	lea	14(a0),a1
	rts

; AMOSPro_Help.AMOS uses this function
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; 	SLOAD file,adress,length
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSload
; - - - - - - - - - - - - -
	tst.l	d3			Length
	Rbmi	L_IFonc	
	move.l	(a3)+,d0		Adress (or bank)
	Rjsr	L_Bnk.OrAdr
	move.l	d0,d2
	move.l	(a3)+,d0		File
	cmp.l	#10,d0
	Rbcc	L_IFonc
	subq.l	#1,d0
	Rbmi	L_IFonc
	mulu	#TFiche,d0
	lea	Fichiers(a5),a2
	add.w	d0,a2
	move.l	FhA(a2),d1
	Rbeq	L_IFonc
	btst	#2,FhT(a2)
	Rbne	L_IFonc
; Load the data
	move.l	a6,-(sp)
	move.l	DosBase(a5),a6
	jsr	-42(a6)			DosRead
	move.l	(sp)+,a6
	tst.l	d0
	Rbmi	L_IDError
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAMPLAY routine
;	A1= Sample
;	D3= Freq
;	D2= Long
;	D1= Voice
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	SPlay
; - - - - - - - - - - - - -
	movem.l	d0-d6/a0-a2,-(sp)
	moveq	#0,d6
	Rbra	L_SPl0
; - - - - - - - - - - - - -
	Lib_Def	SPl0		
; - - - - - - - - - - - - -
	movem.l	a4,-(sp)

	moveq	#0,d0
	bset	d1,d0			* Stop voice
	move.w	d0,DmaCon(a2)

	lea	Sami_int-MB(a3),a4
	move.w	#Sami_intl,d0
	mulu	d1,d0
	add.w	d0,a4			* a4-> Sami interrupts
	move.w	Sami_bit(a4),IntEna(a2)	* No more interrupts

	lea	$a0(a2),a2
	move.w	d1,d4
	lsl.w	#4,d4
	add.w	d4,a2			* a2-> I/O

	move.w	#1,$4(a2)
	move.l	a1,Sami_adr(a4)			* Adresse
	move.l	d2,Sami_long(a4)		* Longueur
	clr.l	Sami_pos(a4)			* Position
	clr.l	Sami_rpos(a4)			* Sam loop on?
	btst	d1,SamLoops+1-MB(a3)
	bne.s	.skipa
	subq.l	#1,Sami_rpos(a4)
.skipa	clr.l	Sami_radr(a4)			* Pas de double buffer	
	move.l	d6,d5
	move.l	MusClock-MB(a3),d6
	bsr	Div32
	cmp.l	#123,d0
	bcc.s	.skip0
	moveq	#123,d0
.skip0	move.w	d0,6(a2)			* AudPer
	move.w	Sami_bit(a4),d0
	or.w	d0,Sami_bits-MB(a3)

* Va demarrer le son...
	lea	Circuits,a0
	move.l	a4,a1
	move.l	Sami_handad-MB(a3),a2
	jsr	(a2)
* Fini!
	move.l	(sp)+,a4
	movem.l	(sp)+,d0-d6/a0-a2
	bset	d1,d0
	rts
; - - - - - - - - - - - - -
; Division 32 bits
; D6/D3 -> D0
Div32	movem.l	d1/d3/d4/d5/d6,-(sp)
	moveq 	#31,d5
        moveq 	#-1,d4
        clr.l 	d1
dv2:    lsl.l 	#1,d6
        roxl.l 	#1,d1
        cmp.l 	d3,d1
        bcs.s 	dv1
        sub.l 	d3,d1
        lsr 	#1,d4
dv1:    roxl.l 	#1,d0
        dbra 	d5,dv2
	movem.l	(sp)+,d1/d3/d4/d5/d6
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	STOP SAMPLES INTERRUPTS
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	Sami_stop	
; - - - - - - - - - - - - -
	move.w	#%0000011110000000,d0
	move.w	d0,Circuits+IntEna
	move.w	d0,Circuits+IntReq
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	LED INSTRUCTION
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InLedOn		
; - - - - - - - - - - - - -
	bclr	#1,$BFE001
	rts
; - - - - - - - - - - - - -
	Lib_Par	InLedOf		
; - - - - - - - - - - - - -
	bset	#1,$BFE001
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	INSTALL THE SAMPLE HANDLER
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	Sami_install	
; - - - - - - - - - - - - -
	tst.w	Sami_flag-MB(a3)
	bne.s	.skip
	movem.l	d0-d2/a0-a2/a6,-(sp)
	move.l	$4.w,a6
; Save state of interrupts
	move.w	Circuits+IntEnaR,d0
	and.w	#%0000011110000000,d0
	move.w	d0,Sami_oldena-MB(a3)
	Rbsr	L_Sami_stop
; Install 4 voices
	lea	Sami_int-MB(a3),a1
	moveq	#7,d0
.loop	bsr.s	Sami_start
	lea	Sami_intl(a1),a1
	addq.w	#1,d0
	cmp.w	#11,d0
	bne.s	.loop
	subq.w	#1,Sami_flag-MB(a3)
	movem.l	(sp)+,d0-d2/a0-a2/a6
.skip	rts
Sami_start
	move.l	a1,is_data(a1)
	move.l	Sami_handad-MB(a3),is_code(a1)
	move.b	#2,ln_type(a1)
	move.b	#0,ln_pri(a1)
	move.l	$4.w,a6	
	movem.l	d0/a1,-(sp)
	jsr	-162(a6)		SetIntVector
	move.l	d0,d1
	movem.l	(sp)+,d0/a1
	move.l	d1,Sami_old(a1)
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	REMOVE THE SAMPLE HANDLER
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	Sami_remove	
; - - - - - - - - - - - - -
	tst.w	Sami_flag-MB(a3)
	beq.s	.skip
	movem.l	a0-a2/a6/d0-d2,-(sp)
	Rbsr	L_Sami_stop
	move.l	$4.w,a6
	moveq	#7,d2
	lea	Sami_int-MB(a3),a2
.loop	move.l	Sami_old(a2),a1
	move.l	d2,d0
	jsr	-162(a6)		SetIntVector
	lea	Sami_intl(a2),a2
	addq.w	#1,d2	
	cmp.w	#11,d2
	bne.s	.loop
	lea	Circuits,a0
	move.w	#$000F,DmaCon(a0)
	move.w	Sami_oldena-MB(a3),IntEna(a0)
	clr.w	Sami_flag-MB(a3)
	movem.l	(sp)+,a0-a2/a6/d0-d2
.skip	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	Normal error messages
	Lib_Def	IOOMem	
; - - - - - - - - - - - - -
	moveq	#24,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	IFonc		
; - - - - - - - - - - - - -
	moveq	#23,d0
	Rjmp	L_Error


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; 	Customized error messages
	Lib_Def	WNDef		
; - - - - - - - - - - - - -
	move.w	#0+178,d0	
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	SNDef		
; - - - - - - - - - - - - -
	move.w	#1+178,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	BNSam		
; - - - - - - - - - - - - -
	move.w	#2+178,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	STSho		
; - - - - - - - - - - - - -
	move.w	#3+178,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	W0Res		
; - - - - - - - - - - - - -
	move.w	#4+178,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	MnRes		
; - - - - - - - - - - - - -
	move.w	#5+178,d0
	Rjmp	L_Error
; - - - - - - - - - - - - -
	Lib_Def	MNDef		
; - - - - - - - - - - - - -
	move.w	#6+178,d0
	Rjmp	L_Error


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	=SAM SWAPPED(V)
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	FnSamSwapped	
; - - - - - - - - - - - - -
	move.l	d3,d0
	moveq	#0,d3
	cmp.l	#3,d0
	Rbhi	L_IFonc
	move.w	Circuits+IntEnaR,d1
	lsr.w	#7,d1
	btst	d0,d1
	beq.s	.stop
	Dlea	Sami_int,a0
	mulu	#Sami_intl,d0
	tst.l	Sami_radr(a0,d0.l)
	bne.s	.out
	move.l	Sami_pos(a0,d0.l),d1
	cmp.l	#Sami_lplay,d1
	beq.s	.out
	moveq	#-1,d3
	bra.s	.out
.stop	moveq	#1,d3
.out	Ret_Int


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAM SWAP
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamSwap	
; - - - - - - - - - - - - -
	move.l	d3,d4
	Rbmi	L_IFonc
	move.l	(a3)+,d0
	Rjsr	L_Bnk.OrAdr
	move.l	d0,d3
	move.l	(a3)+,d2
	moveq	#0,d1
	Dlea	Sami_int,a0
.loop	btst	d1,d2
	beq.s	.skip
	move.l	d3,Sami_radr(a0)
	move.l	d4,Sami_rlong(a0)
.skip	lea	Sami_intl(a0),a0
	addq.w	#1,d1
	cmp.w	#4,d1
	bne.s	.loop
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SAM STOP
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSamStop0	
; - - - - - - - - - - - - -
	moveq	#%1111,d3
	Rbra	L_InSamStop1
; - - - - - - - - - - - - -
	Lib_Par InSamStop1	
; - - - - - - - - - - - - -
	move.l	d3,d1
	and.l	#$F,d1
	move.w	d1,Circuits+DmaCon
	lsl.w	#7,d1	
	move.w	d1,Circuits+IntEna
	rts


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	Disk error
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Def	IDError	
; - - - - - - - - - - - - -
	move.w	#DEBase+15,d0
	Rjmp	L_Error


; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	SSAVE 	File, adress to end
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	InSsave		
; - - - - - - - - - - - - -
	move.l	(a3)+,d2		Start Adress (d3=start ad)
	sub.l	d2,d3
	Rble	L_IFonc
	move.l	(a3)+,d0		File
	cmp.l	#10,d0
	Rbcc	L_IFonc
	subq.l	#1,d0
	Rbmi	L_IFonc
	mulu	#TFiche,d0
	lea	Fichiers(a5),a2
	add.w	d0,a2
	move.l	FhA(a2),d1
	Rbeq	L_IFonc
	btst	#2,FhT(a2)
	Rbne	L_IFonc
* Save the data
	move.l	a6,-(sp)
	move.l	DosBase(a5),a6
	jsr	_LVOWrite(a6)
	move.l	(sp)+,a6
	tst.l	d0
	Rbmi	L_IDError
	rts

; Amal in +w.s (AMOS.Library) has an internal reference for Vu= to this extension via ExtAdr+ExtNb which may be a problem, please report

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;	Mock call
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Lib_Par	NullPar
	moveq	#0,d0
	rts	
	

; - - - - - - - - - - - - -
	Lib_Empty
	Lib_Empty	
; - - - - - - - - - - - - -	

	Lib_End

C_Title	dc.b	"AMOSPro Samples Only extension V "
	Version
	dc.b	0,"$VER: "
	Version
	dc.b	0
	Even

C_End	dc.w	0
	even