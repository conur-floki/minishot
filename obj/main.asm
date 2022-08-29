;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _cpct_getScreenPtr
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_setVideoMode
	.globl _cpct_drawSprite
	.globl _cpct_disableFirmware
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:6: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:7: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:8: cpct_setVideoMode(0);
	ld	l, #0x00
	call	_cpct_setVideoMode
;src/main.c:9: cpct_setPalette(g_palette, 16);
	ld	hl, #0x0010
	push	hl
	ld	hl, #_g_palette
	push	hl
	call	_cpct_setPalette
;src/main.c:10: cpct_setBorder(HW_BRIGHT_WHITE);
	ld	hl, #0x0b10
	push	hl
	call	_cpct_setPALColour
;src/main.c:13: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, 40, 100);
	ld	hl, #0x6428
	push	hl
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:14: cpct_drawSprite(sp_player_ship, pvmem, SP_PLAYER_SHIP_W, SP_PLAYER_SHIP_H);
	ld	bc, #_sp_player_ship+0
	ld	de, #0x0e06
	push	de
	push	hl
	push	bc
	call	_cpct_drawSprite
;src/main.c:17: while (1);
00102$:
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
