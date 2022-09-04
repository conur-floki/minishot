#include <cpctelera.h>
#include <sprites/g_palette.h>
#include <sprites/my_ship.h>
#include <sprites/bad_ship.h>
#include <sprites/bullet.h>

enum
{
   FALSE = 0,
   TRUE = 1,
   PLAYER_X = 37,
   PLAYER_Y = 200 - SP_PLAYER_SHIP_H,
   ENEMY_INIT_X = 80 - SP_ENEMY_SHIP_W,
   ENEMY_Y = 10,
   BULLET_X = PLAYER_X + 2,
   BULLET_Y = PLAYER_Y - SP_BULLET_H
};

void drawPlayer()
{
   u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, PLAYER_X, PLAYER_Y);
   cpct_drawSprite(sp_player_ship, pvmem, SP_PLAYER_SHIP_W, SP_PLAYER_SHIP_H);
}

void drawEnemy(u8 x)
{
   u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
   cpct_drawSprite(sp_enemy_ship, pvmem, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
}

void eraseEnemy(u8 x)
{
   u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
   cpct_drawSolidBox(pvmem, 0, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
}

void drawBullet()
{
   u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, BULLET_X, BULLET_Y);
   cpct_drawSprite(sp_bullet, pvmem, SP_BULLET_W, SP_BULLET_H);
}

void main(void)
{
   u8 enemy_x = ENEMY_INIT_X;

   cpct_disableFirmware();
   cpct_setVideoMode(0);
   cpct_setPalette(g_palette, 16);
   cpct_setBorder(HW_BRIGHT_WHITE);

   while (TRUE)
   {
      drawPlayer();
      if (enemy_x == 0)
      {
         eraseEnemy(enemy_x);
      }
      else
      {
         drawEnemy(enemy_x);
      }
      drawBullet();

      if (enemy_x == 0)
      {
         enemy_x = ENEMY_INIT_X;
      }
      else
      {
         enemy_x = enemy_x - 1;
      }

      cpct_waitVSYNC();
   }
}
