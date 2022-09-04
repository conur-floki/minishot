.area _DATA
.area _CODE

.include "cpctelera.h.s"

.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_drawSolidBox_asm
.globl cpct_waitVSYNC_asm
.globl _g_palette
.globl _sp_player_ship
.globl _sp_enemy_ship
.globl _sp_bullet

SP_PLAYER_SHIP_W = 6
SP_PLAYER_SHIP_H = 14
SP_ENEMY_SHIP_W = 13
SP_ENEMY_SHIP_H = 16
SP_BULLET_W = 1
SP_BULLET_H = 7

FALSE = 0
TRUE = 1 
PLAYER_X = 37
PLAYER_Y = 200 - SP_PLAYER_SHIP_H
ENEMY_INIT_X = 80 - SP_ENEMY_SHIP_W
ENEMY_Y = 10
enemy_x = 0
BULLET_X = PLAYER_X + 2
BULLET_Y = PLAYER_Y - SP_BULLET_H

drawPlayer:
    ld de, #CPCT_VMEM_START_ASM
    ld c, #PLAYER_X
    ld b, #PLAYER_Y
    call cpct_getScreenPtr_asm
   
    ex de, hl
    ld hl, #_sp_player_ship
    ld b, #SP_PLAYER_SHIP_H
    ld c, #SP_PLAYER_SHIP_W
    call cpct_drawSprite_asm

    ret

drawEnemy:
    ld de, #CPCT_VMEM_START_ASM
    ld b, #ENEMY_Y
    call cpct_getScreenPtr_asm
   
    ex de, hl
    ld hl, #_sp_enemy_ship
    ld b, #SP_ENEMY_SHIP_H
    ld c, #SP_ENEMY_SHIP_W
    call cpct_drawSprite_asm

    ret

eraseEnemy:
    ld de, #CPCT_VMEM_START_ASM
    ld b, #ENEMY_Y
    call cpct_getScreenPtr_asm
   
    ex de, hl
    ld a, #0
    ld b, #SP_ENEMY_SHIP_H
    ld c, #SP_ENEMY_SHIP_W
    call cpct_drawSolidBox_asm

    ret    

drawBullet:
    ld de, #CPCT_VMEM_START_ASM
    ld c, #BULLET_X
    ld b, #BULLET_Y
    call cpct_getScreenPtr_asm
   
    ex de, hl
    ld hl, #_sp_bullet
    ld b, #SP_BULLET_H
    ld c, #SP_BULLET_W
    call cpct_drawSprite_asm

    ret


_main::
    ld ix, #-1
    add ix, sp
    ld sp, ix

    ld enemy_x(ix), #ENEMY_INIT_X

    call cpct_disableFirmware_asm
    
    ld c, #0
    call cpct_setVideoMode_asm
    
    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm
    cpctm_setBorder_asm HW_BLACK
    
loop:
    call drawPlayer

    ld a, enemy_x(ix)
    cp #0
    jr z, draw_enemy_at_0

        ;; draw_enemy_not_at_0
        ld c, enemy_x(ix)
        call drawEnemy
        jr draw_enemy_end_if

    draw_enemy_at_0:   
        ld c, enemy_x(ix)
        call eraseEnemy
    
    draw_enemy_end_if:

    call drawBullet

    ld a, enemy_x(ix)
    cp #0
    jr z, enemy_is_at_0
        ;; enemy_x != 0
        dec a
        ld enemy_x(ix), a
        jr enemy_is_at_end_if

    ;; enemy_x != 0
    enemy_is_at_0:
        ld enemy_x(ix), #ENEMY_INIT_X

    enemy_is_at_end_if:
    
    call cpct_waitVSYNC_asm

    jr loop
