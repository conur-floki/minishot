                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _eraseBullet
                             13 	.globl _drawBullet
                             14 	.globl _eraseEnemy
                             15 	.globl _drawEnemy
                             16 	.globl _drawPlayer
                             17 	.globl _cpct_getScreenPtr
                             18 	.globl _cpct_setPALColour
                             19 	.globl _cpct_setPalette
                             20 	.globl _cpct_waitVSYNC
                             21 	.globl _cpct_setVideoMode
                             22 	.globl _cpct_drawSprite
                             23 	.globl _cpct_drawSolidBox
                             24 	.globl _cpct_disableFirmware
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/main.c:21: void drawPlayer()
                             57 ;	---------------------------------
                             58 ; Function drawPlayer
                             59 ; ---------------------------------
   413C                      60 _drawPlayer::
                             61 ;src/main.c:23: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, PLAYER_X, PLAYER_Y);
   413C 21 25 BA      [10]   62 	ld	hl, #0xba25
   413F E5            [11]   63 	push	hl
   4140 21 00 C0      [10]   64 	ld	hl, #0xc000
   4143 E5            [11]   65 	push	hl
   4144 CD E1 43      [17]   66 	call	_cpct_getScreenPtr
                             67 ;src/main.c:24: cpct_drawSprite(sp_player_ship, pvmem, SP_PLAYER_SHIP_W, SP_PLAYER_SHIP_H);
   4147 01 D8 40      [10]   68 	ld	bc, #_sp_player_ship+0
   414A 11 06 0E      [10]   69 	ld	de, #0x0e06
   414D D5            [11]   70 	push	de
   414E E5            [11]   71 	push	hl
   414F C5            [11]   72 	push	bc
   4150 CD 6E 42      [17]   73 	call	_cpct_drawSprite
   4153 C9            [10]   74 	ret
                             75 ;src/main.c:27: void drawEnemy(u8 x)
                             76 ;	---------------------------------
                             77 ; Function drawEnemy
                             78 ; ---------------------------------
   4154                      79 _drawEnemy::
   4154 DD E5         [15]   80 	push	ix
   4156 DD 21 00 00   [14]   81 	ld	ix,#0
   415A DD 39         [15]   82 	add	ix,sp
                             83 ;src/main.c:29: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
   415C 3E 0A         [ 7]   84 	ld	a, #0x0a
   415E F5            [11]   85 	push	af
   415F 33            [ 6]   86 	inc	sp
   4160 DD 7E 04      [19]   87 	ld	a, 4 (ix)
   4163 F5            [11]   88 	push	af
   4164 33            [ 6]   89 	inc	sp
   4165 21 00 C0      [10]   90 	ld	hl, #0xc000
   4168 E5            [11]   91 	push	hl
   4169 CD E1 43      [17]   92 	call	_cpct_getScreenPtr
                             93 ;src/main.c:30: cpct_drawSprite(sp_enemy_ship, pvmem, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
   416C 01 08 40      [10]   94 	ld	bc, #_sp_enemy_ship+0
   416F 11 0D 10      [10]   95 	ld	de, #0x100d
   4172 D5            [11]   96 	push	de
   4173 E5            [11]   97 	push	hl
   4174 C5            [11]   98 	push	bc
   4175 CD 6E 42      [17]   99 	call	_cpct_drawSprite
   4178 DD E1         [14]  100 	pop	ix
   417A C9            [10]  101 	ret
                            102 ;src/main.c:33: void eraseEnemy(u8 x)
                            103 ;	---------------------------------
                            104 ; Function eraseEnemy
                            105 ; ---------------------------------
   417B                     106 _eraseEnemy::
                            107 ;src/main.c:35: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, ENEMY_Y);
   417B 3E 0A         [ 7]  108 	ld	a, #0x0a
   417D F5            [11]  109 	push	af
   417E 33            [ 6]  110 	inc	sp
   417F 21 03 00      [10]  111 	ld	hl, #3+0
   4182 39            [11]  112 	add	hl, sp
   4183 7E            [ 7]  113 	ld	a, (hl)
   4184 F5            [11]  114 	push	af
   4185 33            [ 6]  115 	inc	sp
   4186 21 00 C0      [10]  116 	ld	hl, #0xc000
   4189 E5            [11]  117 	push	hl
   418A CD E1 43      [17]  118 	call	_cpct_getScreenPtr
                            119 ;src/main.c:36: cpct_drawSolidBox(pvmem, 0, SP_ENEMY_SHIP_W, SP_ENEMY_SHIP_H);
   418D 01 0D 10      [10]  120 	ld	bc, #0x100d
   4190 C5            [11]  121 	push	bc
   4191 01 00 00      [10]  122 	ld	bc, #0x0000
   4194 C5            [11]  123 	push	bc
   4195 E5            [11]  124 	push	hl
   4196 CD 39 43      [17]  125 	call	_cpct_drawSolidBox
   4199 C9            [10]  126 	ret
                            127 ;src/main.c:39: void drawBullet(u8 y)
                            128 ;	---------------------------------
                            129 ; Function drawBullet
                            130 ; ---------------------------------
   419A                     131 _drawBullet::
   419A DD E5         [15]  132 	push	ix
   419C DD 21 00 00   [14]  133 	ld	ix,#0
   41A0 DD 39         [15]  134 	add	ix,sp
                            135 ;src/main.c:41: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, BULLET_X, y);
   41A2 DD 56 04      [19]  136 	ld	d, 4 (ix)
   41A5 1E 27         [ 7]  137 	ld	e,#0x27
   41A7 D5            [11]  138 	push	de
   41A8 21 00 C0      [10]  139 	ld	hl, #0xc000
   41AB E5            [11]  140 	push	hl
   41AC CD E1 43      [17]  141 	call	_cpct_getScreenPtr
                            142 ;src/main.c:42: cpct_drawSprite(sp_bullet, pvmem, SP_BULLET_W, SP_BULLET_H);
   41AF 01 00 40      [10]  143 	ld	bc, #_sp_bullet+0
   41B2 11 01 08      [10]  144 	ld	de, #0x0801
   41B5 D5            [11]  145 	push	de
   41B6 E5            [11]  146 	push	hl
   41B7 C5            [11]  147 	push	bc
   41B8 CD 6E 42      [17]  148 	call	_cpct_drawSprite
   41BB DD E1         [14]  149 	pop	ix
   41BD C9            [10]  150 	ret
                            151 ;src/main.c:45: void eraseBullet(u8 y)
                            152 ;	---------------------------------
                            153 ; Function eraseBullet
                            154 ; ---------------------------------
   41BE                     155 _eraseBullet::
                            156 ;src/main.c:47: u8 *pvmem = cpct_getScreenPtr(CPCT_VMEM_START, BULLET_X, y);
   41BE 21 02 00      [10]  157 	ld	hl, #2+0
   41C1 39            [11]  158 	add	hl, sp
   41C2 56            [ 7]  159 	ld	d, (hl)
   41C3 1E 27         [ 7]  160 	ld	e,#0x27
   41C5 D5            [11]  161 	push	de
   41C6 21 00 C0      [10]  162 	ld	hl, #0xc000
   41C9 E5            [11]  163 	push	hl
   41CA CD E1 43      [17]  164 	call	_cpct_getScreenPtr
                            165 ;src/main.c:48: cpct_drawSolidBox(pvmem, 0, SP_BULLET_W, SP_BULLET_H);
   41CD 01 01 08      [10]  166 	ld	bc, #0x0801
   41D0 C5            [11]  167 	push	bc
   41D1 01 00 00      [10]  168 	ld	bc, #0x0000
   41D4 C5            [11]  169 	push	bc
   41D5 E5            [11]  170 	push	hl
   41D6 CD 39 43      [17]  171 	call	_cpct_drawSolidBox
   41D9 C9            [10]  172 	ret
                            173 ;src/main.c:51: void main(void)
                            174 ;	---------------------------------
                            175 ; Function main
                            176 ; ---------------------------------
   41DA                     177 _main::
                            178 ;src/main.c:53: u8 enemy_x = ENEMY_INIT_X;
                            179 ;src/main.c:54: u8 bullet_y = BULLET_INIT_Y;
   41DA 01 B2 43      [10]  180 	ld	bc,#0x43b2
                            181 ;src/main.c:57: cpct_disableFirmware();
   41DD C5            [11]  182 	push	bc
   41DE CD 29 43      [17]  183 	call	_cpct_disableFirmware
   41E1 2E 00         [ 7]  184 	ld	l, #0x00
   41E3 CD 1B 43      [17]  185 	call	_cpct_setVideoMode
   41E6 21 10 00      [10]  186 	ld	hl, #0x0010
   41E9 E5            [11]  187 	push	hl
   41EA 21 2C 41      [10]  188 	ld	hl, #_g_palette
   41ED E5            [11]  189 	push	hl
   41EE CD 4B 42      [17]  190 	call	_cpct_setPalette
   41F1 21 10 0B      [10]  191 	ld	hl, #0x0b10
   41F4 E5            [11]  192 	push	hl
   41F5 CD 62 42      [17]  193 	call	_cpct_setPALColour
   41F8 C1            [10]  194 	pop	bc
                            195 ;src/main.c:62: while (TRUE)
   41F9                     196 00116$:
                            197 ;src/main.c:64: drawPlayer();
   41F9 C5            [11]  198 	push	bc
   41FA CD 3C 41      [17]  199 	call	_drawPlayer
   41FD C1            [10]  200 	pop	bc
                            201 ;src/main.c:66: if (enemy_x == 0)
   41FE 78            [ 4]  202 	ld	a, b
   41FF B7            [ 4]  203 	or	a, a
   4200 20 0A         [12]  204 	jr	NZ,00102$
                            205 ;src/main.c:68: eraseEnemy(enemy_x);
   4202 C5            [11]  206 	push	bc
   4203 C5            [11]  207 	push	bc
   4204 33            [ 6]  208 	inc	sp
   4205 CD 7B 41      [17]  209 	call	_eraseEnemy
   4208 33            [ 6]  210 	inc	sp
   4209 C1            [10]  211 	pop	bc
   420A 18 08         [12]  212 	jr	00103$
   420C                     213 00102$:
                            214 ;src/main.c:72: drawEnemy(enemy_x);
   420C C5            [11]  215 	push	bc
   420D C5            [11]  216 	push	bc
   420E 33            [ 6]  217 	inc	sp
   420F CD 54 41      [17]  218 	call	_drawEnemy
   4212 33            [ 6]  219 	inc	sp
   4213 C1            [10]  220 	pop	bc
   4214                     221 00103$:
                            222 ;src/main.c:77: if (bullet_y == 0)
   4214 79            [ 4]  223 	ld	a, c
   4215 B7            [ 4]  224 	or	a, a
   4216 20 0B         [12]  225 	jr	NZ,00105$
                            226 ;src/main.c:79: eraseBullet(bullet_y);
   4218 C5            [11]  227 	push	bc
   4219 79            [ 4]  228 	ld	a, c
   421A F5            [11]  229 	push	af
   421B 33            [ 6]  230 	inc	sp
   421C CD BE 41      [17]  231 	call	_eraseBullet
   421F 33            [ 6]  232 	inc	sp
   4220 C1            [10]  233 	pop	bc
   4221 18 09         [12]  234 	jr	00108$
   4223                     235 00105$:
                            236 ;src/main.c:83: drawBullet(bullet_y);
   4223 C5            [11]  237 	push	bc
   4224 79            [ 4]  238 	ld	a, c
   4225 F5            [11]  239 	push	af
   4226 33            [ 6]  240 	inc	sp
   4227 CD 9A 41      [17]  241 	call	_drawBullet
   422A 33            [ 6]  242 	inc	sp
   422B C1            [10]  243 	pop	bc
   422C                     244 00108$:
                            245 ;src/main.c:87: if (enemy_x == 0)
   422C 78            [ 4]  246 	ld	a, b
   422D B7            [ 4]  247 	or	a, a
   422E 20 04         [12]  248 	jr	NZ,00110$
                            249 ;src/main.c:89: enemy_x = ENEMY_INIT_X;
   4230 06 43         [ 7]  250 	ld	b, #0x43
   4232 18 04         [12]  251 	jr	00111$
   4234                     252 00110$:
                            253 ;src/main.c:93: enemy_x = enemy_x += ENEMY_VX;
   4234 78            [ 4]  254 	ld	a, b
   4235 C6 FF         [ 7]  255 	add	a, #0xff
   4237 47            [ 4]  256 	ld	b, a
   4238                     257 00111$:
                            258 ;src/main.c:96: if (bullet_y == 0)
   4238 79            [ 4]  259 	ld	a, c
   4239 B7            [ 4]  260 	or	a, a
   423A 20 04         [12]  261 	jr	NZ,00113$
                            262 ;src/main.c:98: bullet_y = BULLET_INIT_Y;
   423C 0E B2         [ 7]  263 	ld	c, #0xb2
   423E 18 04         [12]  264 	jr	00114$
   4240                     265 00113$:
                            266 ;src/main.c:102: bullet_y = bullet_y += BULLET_VY;
   4240 79            [ 4]  267 	ld	a, c
   4241 C6 FE         [ 7]  268 	add	a, #0xfe
   4243 4F            [ 4]  269 	ld	c, a
   4244                     270 00114$:
                            271 ;src/main.c:105: cpct_waitVSYNC();
   4244 C5            [11]  272 	push	bc
   4245 CD 13 43      [17]  273 	call	_cpct_waitVSYNC
   4248 C1            [10]  274 	pop	bc
   4249 18 AE         [12]  275 	jr	00116$
                            276 	.area _CODE
                            277 	.area _INITIALIZER
                            278 	.area _CABS (ABS)
