.area _DATA
.area _CODE

.include "cpctelera.h.s"

.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl _g_palette
.globl _sp_player_ship

SP_PLAYER_SHIP_W = 6
SP_PLAYER_SHIP_H = 14

_main::
    call cpct_disableFirmware_asm
    
    ld c, #0
    call cpct_setVideoMode_asm
    
    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm
    
    cpctm_setBorder_asm HW_BLACK
    
    ld de, #CPCT_VMEM_START_ASM
    ld b, #100
    ld c, #40
    call cpct_getScreenPtr_asm
   
    ex de, hl
    ld hl, #_sp_player_ship
    ld b, #SP_PLAYER_SHIP_H
    ld c, #SP_PLAYER_SHIP_W
    call cpct_drawSprite_asm

loop:
    jr loop