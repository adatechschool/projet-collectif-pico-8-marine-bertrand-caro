pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

function _init()
	pl = {
		x=20, y=20,
		dx=0, dy=0, --init vitesse
		speed = 1,
		w = 8, h =8 --largeur et hauteur
		}
end


function _update()
 if (btn(➡️)) pl.dx+=pl.speed
 if (btn(⬅️)) pl.dx-=pl.speed
 if (btn(⬆️)) pl.dy-=pl.speed
 if (btn(⬇️)) pl.dy+=pl.speed
 
 --gestion mv diag
 if can_move(pl.x+pl.dx, pl.y, pl.w, pl.h)
	then pl.x += pl.dx
end
if can_move(pl.x, pl.y+pl.dy, pl.w, pl.h)
	then pl.y += pl.dy
end

pl.dx, pl.dy = 0,0

if (check_object(pl.x, pl.y))
	then get_object(pl.x, pl.y)
end

end

function _draw()
cls()
 map(0,0,0,0,128,128)
	update_camera()
 if not (btn(➡️) or btn(⬅️) or btn(⬆️) or btn(⬇️)) then
 spr(65, pl.x, pl.y)
	end
 	if btn(➡️) then
  spr(69, pl.x, pl.y)
  elseif btn(⬅️) then
	 spr(69, pl.x, pl.y, 1, 1, true)
		end
 		if btn(⬆️) then
			spr(67, pl.x, pl.y)
			elseif btn(⬇️) then
			spr(65, pl.x, pl.y)
 		end
end




-->8
--mouvement

function can_move(x, y, w, h)
	if (check_obstacle(x, y)) return false         -- coin haut-gauche
	if (check_obstacle(x+w-1, y)) return false     -- coin haut-droite
	if (check_obstacle(x, y+h-1)) return false     -- coin bas-gauche
	if (check_obstacle(x+w-1, y+h-1)) return false -- coin bas-droite
	return true
end


function check_obstacle(x,y)
	local map_x = flr(x/8)
	local map_y = flr(y/8)
	local sprite = mget(map_x, map_y)
	return fget(sprite, 0)
end
-->8
--camera

function update_camera()
	local camx=flr(pl.x/128)
	local camy=flr(pl.y/128)
	camera(camx*128,camy*128)
end
-->8
--get object

function get_object(x,y)
	local sprite_x=flr(x/8)
	local sprite_y=flr(y/8)
	local sprite=mget(sprite_x, sprite_y)
	mset(sprite_x, sprite_y, sprite+1)
	sfx(0)
end

function check_object(x,y)
	local obj_x = flr(x/8)
	local obj_y = flr(y/8)
	local sprite = mget(obj_x, obj_y)
 return fget(sprite, 1)
end
__gfx__
00000000333333333333333333bbbb33333333331111111111111111444444444444444400000000ffffffff9999999999999999fffffff5455fffff00000000
0000000033333333332333333bbaab13366666331111111111111111444444444444444400000000ffffffff9999999999855899ffffff544885ffff00000000
0070070033333333329233333bbbab1366ddd6631111111111111111666666666666666600000000ffffffff9999999999855899fffff55448855fff00000000
00077000333333333323333331bbb31366d506631111111111111111cccccccccccccccc00000000ffffffff99999999988aa889ffff85448a885fff00000000
0007700033333333333333233314113366dd56631111111111111111111111111111111100000000ffffffff99999999988a0889fff5884988a88fff00000000
00700700333333333333329233344333666666631111111111111111111111111111111100000000ffffffff9999999998855889ff55584988a8948f00000000
00000000333333333333332333444433366666331111111111111111111111111111111100000000ffffffff9999999999588599f885a4898aa9888500000000
00000000333333333333333333333333333333331111111111111111111111111111111100000000ffffffff9999999999999999f588aa988aaa88a500000000
00000000bbbbbbbbbbbbbbbb33333333bbbbbbbb1111111111111111111111111111111100000000899999599999989900000000f5584a8a88a88a4500000000
00000000bbbbabbbbbbbbbbb33333e33b66666bb1111111111111111000000000000000000000000989999559559999900000000f5448aa88aa8aaa800000000
00000000bbababbbbbbbbbbb3333eae366ddd66b1111111111111111000000000000000000000000999559558588999800000000f84a98a88aaaaa8800000000
00000000bbaaabbbbbbbbbbb33333e3366d5066b1111111111111111000000000000000000000000989955588884498900000000588aaaaaaaa5a88500000000
00000000bbbabbabbbbbbbbb3338333366dd566b11111111111111110000000000000000000000009989955888489999000000005548a9a5aa55884500000000
00000000bbbbbaabbbbbbbbb338a83336666666b1111111111111111000000000000000000000000995558958888589900000000f54999a55555554f00000000
00000000bbbbbabbbbbbbbbb33383333b66666bb1111111111111111000000000000000000000000599558858485889900000000f5444555580554ff00000000
00000000bbbbbbbbbbbbbbbb33333333bbbbbbbb1111111111111111000000000000000000000000559548858858898900000000ff55445580084fff00000000
14441111111144411114441111444111000000009999999944444444111111111141141100000000954544888888959900000000000000000000000000000000
14441111111144411114444444444111000440009666669944444444111111111144441100000000554584885885548900000000000000000000000000000000
144444444444444111144444444441110044440066ddd669444444441111111111411411000000009544848a58a4588400000000000000000000000000000000
1444444444444441111444111144411104e44e4066d5066944444444444444441144441100000000995448aaa4a8444900000000000000000000000000000000
144411111111444111144411114441114ee44ee466dd5669444444444141414111411411000000009995484aaaaa8a8900000000000000000000000000000000
14441111111144411114444444444111444ff44466666669444444444141414111444411000000009995a8aaaaaaaa9900000000000000000000000000000000
1444444444444441111444444444411144444444966666994444444444444444114114110000000099999aaaaaaaa99900000000000000000000000000000000
1444444444444441111444111144411104f00f409999999944444444111111111144441100000000999999999999999900000000000000000000000000000000
14441111111144411114441111444111bb3333bbffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
14441111111144411114444444444111b33aa31bf66666ff00000000000000000000000000000000000000000000000000000000000000000000000000000000
14444444444444411114444444444111b333a31b66ddd66f00000000000000000000000000000000000000000000000000000000000000000000000000000000
14444444444444411114441111444111b1333d1b66d5066f00000000000000000000000000000000000000000000000000000000000000000000000000000000
14441111111144411114441111444111bb1411bb66dd566f00000000000000000000000000000000000000000000000000000000000000000000000000000000
14441111111144411114444444444111bbb44bbb6666666f00000000000000000000000000000000000000000000000000000000000000000000000000000000
14444444444444411114444444444111bb4444bbf66666ff00000000000000000000000000000000000000000000000000000000000000000000000000000000
14444444444444411114441111444111bbbbbbbbffffffff77777777777777777777777777777777777777777777777777777777777777777777777777777777
00000000011001100110011001100110011001100010001000100010ffff7fff7777777733333333333373339999999999997999999979990000000099993999
00000000011111100111111001111110011111100011111100111111ffff77ff7777777733333773333377339999977999997799999977990000000049949949
0070070001c11c1001c11c100111111001111110001c11c1001c11c1fff7757f7777777733337887333775739999788799977579999775790000000049949499
00077000011111100111111001111110011111100011111100111111ff776fff7777777733778887337763339977888799776999997769990000000094944999
000770000111111001111110011111100111111010111111101111117776ffff7777777737888887777633339788888777769999777699990000000099444999
00700700000110011001100000011001100110001000110010001100f75fffff7777777737878873375333339787887997599999975999990000000099944999
00000000011111111111111001111111111111100111110001111100ff7fffff7777777737888733337333339788879999799999997999990000000099944999
00000000011001100110011001100110011001101000001000101000ffffffff7777777733777333333333339977799999999999999999990000000099444499
00000000f11ff11f91199119000000000000000000000000000000000000000000000000bbbbbbbbbbbb7bbbffffffffffff7fff4444444444447444ffffffff
00000000f111111fa1111119000000000000000000000000000000000000000000000000bbbbb77bbbbb77bbfffff77fffff77ff44444774444477444ff4ff4f
0000000091c11c1fa1c11c1a000000000000000000000000000000000000000000000000bbbb7887bbb7757bffff7887fff7757f44447887444775744ff4f4ff
00000000991881199a188119000000000000000000000000000000000000000000000000bb778887bb776bbbff778887ff776fff4477888744776444f4f44fff
0000000099988199999881a9000000000000000000000000000000000000000000000000b78888877776bbbbf78888877776ffff4788888777764444ff444fff
00000000fa98a9919a98a991000000000000000000000000000000000000000000000000b787887bb75bbbbbf787887ff75fffff4787887447544444fff44fff
00000000a9119aa1a9119aa1000000000000000000000000000000000000000000000000b78887bbbb7bbbbbf78887ffff7fffff4788874444744444fff44fff
000000009119999991199999000000000000000000000000000000000000000000000000bb777bbbbbbbbbbbff777fffffffffff4477744444444444ff4444ff
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5353a0a0a0a0a0a05353a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a053b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0c0b0b0b0
b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0a0
53a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0f5f5a0a0a0a0a0a0a0a0a0a053b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0c0c0d4c0b0
b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a074a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0
f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0b0f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0c0b0b0
b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0f5f5
f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0f5a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0c0b0b0b0
b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0f5a0
53f5a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0d4b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a074a0a0a0a0a0a0a0a0a0f5f5a0a0
5353f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0f5
a0a053a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0f4f4b4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0f4b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b5a0a0a0f5a0
5353a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0f4f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
f4f4f4b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0
a053f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0f4b0b0b0b0b0b0b0b0b0d452b0b0d4b0b0b0b0b0b0
b4f452b0a0a0a0a0a0a0a0a074a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0a0
f5f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b052b0b0b0b0b0b0b0b0b0b0
b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e0a0a0d1e1a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5f5a053
f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d115e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0
a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0b0d4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d1e1a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0
a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0a1b1b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a074a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5
f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0a2b2b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0
f5a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0a1b1b0b0b0b0b0b0b0b0b0f4f4b0b0b0b0
b0c0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a074a0a0a0a0a0f5a0a0a0a0a0a0a0a0a053
a05353a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0c0c0b0b0b0b0b0b0b0a2b2b0b0b0b0b0b0b0b0b0f4f4f4b0b0b0
b0c0c0f5a0a0a0a0a0a0a0a0a0a0f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0
a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0c0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0f4f4f4b0b0b0b0
b0b0c0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a053a0
5353a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0c0b0c0b0b0b0b0b0b0b0b0b0b0b0b0b0b0f4f4b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0
53a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0c0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0f5
f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0
f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5
a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5
a0f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b4b0b0f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0f4
f4b0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5b5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0
f5f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0f452
53a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0
a0f5f5a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a052b0b0b0f4f4f4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b052
a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5f5a0
f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0
a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a074a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5f5a0a0a0f5
a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0
a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a05353a0a0a0a0a0a0a0a0a0a0a0a0a0a0a074a0f5f5a0a053a0a0
53a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0
a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0f5a0a0a0a0
53a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0a053a0a0a0a0a0a0a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5a0a0a0a0f5a0a0a0a0
a0a0a0a0f5a0f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a05353a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0f5f5a0a0a0a0a0a0a0a0a0a0a0f5f5a0a0a0a0f5a0
a053a0a05353a0a0f5a0a0a0a0a0a0a0a0a0f5a0a0a0f5f5a0a0a0f5a0a0a0a0a0a0f5f5a0a0a0a0a0a0a053f5a0a0a0a0a0a0f5a0f5a0f5a0a0a0a0a0a0a0a0
a0f5a0f5f5f5a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0535353a0f5a0a0a0a0a0a0a0a0f5a0a0a0a0a0a0f5f5f5f5a0a0a0a0a0a0a0a0f5f5a0a0a0f5a0a0f5a0
a053a05353a0a0a0f5f5f5f5a0f5f5a0a0f5a0a0f5f5a0a0f5a0a0a0a0a0a0a0f5f5f5a0f5f5a0a0a0a0535353f55353a0a0f5f553a0a0a0535353a0a0a053a0
f5a0f5f5f5f5f5f5a0a0f553a0f5a0f5f5a0a0a0a053a053a0a0a0f5a0a0f5a0a0a0f5a0f5f5a0a053a0a0f5f5a053a0a0a0a0f5a0f5a0a0a053a0a0a0a0a0f5
a0a0f5a053535353a0a0f5f5f5f5a0f5f5a05353f5a0a053a0535353535353f5f5f5f5f5f5535353f5f55353a053535353f5f5a0a0a0a0a0a053a0535353a053
f5f5f5f5f5f5f5f5f5f5a0a0f5a053a0a0f5f553f55353535353a0a0f5f5a0f5f553a0a0f5a0f553a05353a0a0535353f5f5f5a053f5a0a053a0a0a0a0a0a0a0
__gff__
0000000101010101010000000101010000000000010101000000010100010100000000000001000000000101000000000000000001010000000000000000000000000000000000000002000200000001000000000000000000020002000200010000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0303040304030303020303030403030334341414341212141403030303031414254f4f0b4f4f25254f0b0b0b0b0b25250c0c0c1a1b0c0c0c0c0b0b0b4f4f254f355f35355f5f5f5f0a5f5f35350a3535355f5f0a0a0a0a0a5f5f5f5f5f0a3535350a0a3535350a5f5f353535355f5f0a5f5f252525254f4f4f0a5f0a0a5f0a0a
0301010101130103030103134903030334121214123434121212010203124a14250b4f25250b0b4f250c0c0b0b0c250b0b0b0c2a2b0b0b0c0b250b0b4f0b0b2535350a0a0a0a5f0a0a5f0a0a35350a0a0a0a5f0a5f0a0a5f5f0a0a5f5f5f350a0a35350a0a355f0a0a5f350a0a0a0a5f250b0b250b254f4f0a350a5f0a5f5f0a
03490101010101010101010101030304111112121234341212121212121212120b4f25250b0b0b0b250b0b0c0c0c0b0c0b0c0c1a1b1a1b4b0b0b25250b0b0b0c0a0a0a0a0a0a0a5f5f0a0a0a0a0a0a0a0a5f5f5f0a0a5f0a0a0a0a0a0a0a5f0a0a0a350a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b4f0a0a0a0a0a5f0a5f0a
04010101010101010101010101010101111212121212121212121212121201010b0b254b0b0b0b250b0b0b0b0b0b0b0c0b0c0b2a2b2a2b0b0b0b0b0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a5f5f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b1a1b0b0b0b0b0b0a0a0a0a0a5f
04130101050520211616160505010201121212121212121212121212120303130b0b0b0b0b0b0b0b0c0b0b0b0c0b0b0b0b0b0c0c1b1a1b0b0b0b0b0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b1a1b0b2a2b0b0b0b0b0a0a0a0a0a0a5f
05050516160520210505050505050505280512121212121212121212123401010a0b0b0b0b0b0b0c0c0c4d0b0b0b0b0b0c0c0b0c0c2a2b0b0b0b0b0b4f4f0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b2a2b0b1a1b1a1b0b0a0a0a0a0a0a5f5f
05050505050520210505052627260506280606161612125916060522230505050a0a0a0b0b0b0b0c0c0c0b0b0b0b0b0b0b0b0b0c0c0b0b0b0b0b0b0b4f0b0b4d470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b2a2b2a2b0a0a0a0a0a0a0a5f0a
0505050505055d2627272726052627272616161616161616161616323316161605050a0b0b0b0b0b0c0c0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b4f0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0a0a0a0a0a0a0a0a5f
050505050505202105050505051616160516161606060616161616222316161616160a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b4d0b0b0b0b0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a5f5f
03030103030301010105050505060606051616160606060606161632331616161616052805470a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b1a1b1a1b0a0a0a0a0a0a0a0a0a0a0a0d0e0a0d0e0d0e470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0b0b0b0a0a0a0a0a0a0a0a0a0a5f0a5f
0302010101030101010303034901010412591212120606061616262626262727272727260506060a0a0b0b0b0b0b4b0b0b0b0b0b0b0b0b0b0b0b0b0b2a2b2a2b0a0a0a0a0a0a0a0a0a0a0a1d1e0a1d1e1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f5f5f
04490401010101010103030313010104121211111206060606165d262626161616161628060606060a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b1a1b1a1b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a470a0a0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a
04040101010101010201030303010104121111111206060606061605050516161616262626050505050a0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b2a2b2a2b0b0b0a0a0a0a0a0a0a0a0a5b0a0a0a0d0e0a1d1e0a0a0d0e0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a5f
04010101010101010101010303014901121211111206060606060605051616161616262626060606060a0b0b0b0b0b0b0b0b0b0b0b0b0b0b4d0b1a521a1b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e0a0a0a0a0a1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
03030101010201010101010101010101121212121206060606060605050616161606060606060606060a0b0b0b0b0b0b0b0b0b0b0b0b0b0b4d0b2a2b2a2b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
0304040113010303010101010201010112121212120a0606060606050506060606060606060606060a0a0a0b0b0a0a0a0a0a0a0b0b0b0b0b0b0b0b0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e0a0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
0304010101010303010101010101010112121213120a0a06060606050506060606060606060606060a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a350a
030101010101010301010101010101011212010112120a060606060505060606060606060606065b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a350a35
030203010101011301010101010101131201010101120a0a0606060505060606060606060606060a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5b0a0a0a0a0a0a0a0a0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a350a
03030301010101010101010101010104121201030112120a0a0a0605050606060606060606060a0a0a0a0a0a0a0a0b0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3535
010103010101010101010101010101041211120101491212120a0a050506060606060606060a0a0a0a0a0a0a0a0a0b0b4d0c0b0b0a0a0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a3535
01030101010103010101010101010404111111120103121212340a0a111111340a0a0a0a0a0a0a0a0a0a0a0a0a0b0b1a1b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a350a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
01030301011301010101010102040404041111121212121212121211121212340a0a0a0a0a0a0a0a0a0a0a0b0b0b0c2a2b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f
010349010101010101010101014904040404040404044a1212121212121234120a0a0a0a0a0a0a0a0a0a0a0b0b0c0b0c0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a47470a0d0e0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a350a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f
03010101010101010101010101010101030201010101010103030303130404040a0a0a0d0e0a0a0a0a0a0a0b0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35350a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f5f
04010101010101010101010101010101030301010101010101030301010101040a0a0a1d1e0a470a0a0a0a0b0b0b0b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e0d0e0d0e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a350a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
04040101010303020101010101010101010101010101010101030101010101010a0d0e0d0e0d0e0a0a0a0a0a4b0b0a0a0a0a0a0a0a0a475b470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e1d1e1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a47470a0a0a0a0a0a0a0a0a0a3535
04010113010101020101010101010101010113010101010101010101010101010a1d1e1d1e1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0d0e510e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a470a0a0a0a0a0a0a0a0a0a0a5f0a
13030101010101010101010101010101010101010101010101010101490201010a0d0e0d0e0d0e5b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1d1e1d1e0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a0a0a0a0a0a0a5f
03490101010101010101010113010101010101010101010101010101020201010a1d1e1d1e1d1e0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a35
04030301010101010104490101010101010101490101010101010101490101010a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f
0404030101010101040301010101010101010101010101010101010101010101470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a470a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a5f0a
__sfx__
00050000377403f7503f7603c7702d1002e1002e1002e1002e100240002600026000260002600025000220001e0001c0001a000190001800018000180001800018000190002e1001a0002e1001c0001d0001e000
000500003a6403f6503f6603c67035600096000b6000c6000d6000e6000f600106000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
