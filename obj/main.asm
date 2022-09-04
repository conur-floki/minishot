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
	.globl _drawBullet
	.globl _eraseEnemy
	.globl _drawEnemy
	.globl _drawPlayer
	.globl _cpct_getScreenPtr
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_waitVSYNC
	.globl _cpct_setVideoMode
	.globl _cpct_drawSprite
	.globl _cpct_drawSolidBox
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
;src/main.c:19: void drawPlayer()
;	---------------------------------
; Function drawPlayer
; ---------------------------------
_drawPlayer::
;src/main.c:21: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, PLAYER_X, PLAYER_Y);
	ld	hl, #0xba25
	push	hl
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:22: cpct_drawSprite(sp_player_ship, pvmem, SP_PLAYER_SHIP_W, SP_PLAYER_SHIP_H);
	ld	bc, #_sp_player_ship+0
	ld	de, #0x0e06
	push	de
	push	hl
	push	bc
	call	_cpct_drawSprite
	ret
;src/main.c:25: void drawEnemy(u8 x)
;	---------------------------------
; Function drawEnemy
; ---------------------------------
_drawEnemy::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/main.c:27: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, 4 (ix)
	push	af
	inc	sp
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:28: cpct_drawSprite(sp_enemy_ship, pvmem, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
	ld	bc, #_sp_enemy_ship+0
	ld	de, #0x100d
	push	de
	push	hl
	push	bc
	call	_cpct_drawSprite
	pop	ix
	ret
;src/main.c:31: void eraseEnemy(u8 x)
;	---------------------------------
; Function eraseEnemy
; ---------------------------------
_eraseEnemy::
;src/main.c:33: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:34: cpct_drawSolidBox(pvmem, 0, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
	ld	bc, #0x100d
	push	bc
	ld	bc, #0x0000
	push	bc
	push	hl
	call	_cpct_drawSolidBox
	ret
;src/main.c:37: void drawBullet()
;	---------------------------------
; Function drawBullet
; ---------------------------------
_drawBullet::
;src/main.c:39: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, BULLET_X, BULLET_Y);
	ld	hl, #0xb327
	push	hl
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
;src/main.c:40: cpct_drawSprite(sp_bullet, pvmem, SP_BULLET_W, SP_BULLET_H);
	ld	bc, #_sp_bullet+0
	ld	de, #0x0701
	push	de
	push	hl
	push	bc
	call	_cpct_drawSprite
	ret
;src/main.c:43: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:45: u8 enemy_x = ENEMY_INIT_X;
	ld	b, #0x43
;src/main.c:47: cpct_disableFirmware();
	push	bc
	call	_cpct_disableFirmware
	ld	l, #0x00
	call	_cpct_setVideoMode
	ld	hl, #0x0010
	push	hl
	ld	hl, #_g_palette
	push	hl
	call	_cpct_setPalette
	ld	hl, #0x0b10
	push	hl
	call	_cpct_setPALColour
	pop	bc
;src/main.c:52: while (TRUE)
00108$:
;src/main.c:54: drawPlayer();
	push	bc
	call	_drawPlayer
	pop	bc
;src/main.c:55: if (enemy_x == 0)
	ld	a, b
	or	a, a
	jr	NZ,00102$
;src/main.c:57: eraseEnemy(enemy_x);
	push	bc
	push	bc
	inc	sp
	call	_eraseEnemy
	inc	sp
	pop	bc
	jr	00103$
00102$:
;src/main.c:61: drawEnemy(enemy_x);
	push	bc
	push	bc
	inc	sp
	call	_drawEnemy
	inc	sp
	pop	bc
00103$:
;src/main.c:63: drawBullet();
	push	bc
	call	_drawBullet
	pop	bc
;src/main.c:65: if (enemy_x == 0)
	ld	a, b
	or	a, a
	jr	NZ,00105$
;src/main.c:67: enemy_x = ENEMY_INIT_X;
	ld	b, #0x43
	jr	00106$
00105$:
;src/main.c:71: enemy_x = enemy_x - 1;
	dec	b
00106$:
;src/main.c:74: cpct_waitVSYNC();
	push	bc
	call	_cpct_waitVSYNC
	pop	bc
	jr	00108$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
