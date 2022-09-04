## 16 colours palette
PALETTE=1 0 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  { 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
#$(eval $(call IMG2SP, SET_FOLDER      , src/               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))

$(eval $(call IMG2SP, SET_FOLDER      , src/sprites))
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)))
$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette))
$(eval $(call IMG2SP, CONVERT         , img/my_ship.png , 0, 0, sp_player_ship))
$(eval $(call IMG2SP, CONVERT         , img/bad_ship.png , 0, 0, sp_enemy_ship))
$(eval $(call IMG2SP, CONVERT         , img/bullet.png , 0, 0, sp_bullet))