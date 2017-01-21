pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--yo this is tom
--code goes here
--totally inspired by johannes richter's guide on picozine 2
--thank you johannes richter

--yo this is tom
--code goes here
--totally inspired by johannes richter's guide on picozine 2
--thank you johannes richter

function _init()
 pat=0 --state timer
 px=20
 py=64
 pstate=0 --current state
 pspr=20 --current sprite
 pdir=0 --current direction
 camerax=0
end

function _draw()
 cls()
 --draw the world �
 map(0,0,0,0,16,16)

 --draw the player
 spr(pspr,px,py,1,1,pdir==-1)
end

function _update()
 b0=btn(0)
 b1=btn(1)
 b2=btn(2)

 px=(px+128)%128 --no bounds left and right
 pat+=1

 --todo: camera stuff

 --idle state
 if pstate==0 then
  pspr=20
  if(b0 or b1)change_state(1)
  if(b2)change_state(3)
  if(canfall())change_state(2)
 end
 
 --walk state
 if pstate==1 then
  if (b0) pdir=-1   
  if (b1) pdir=1   
  px+=pdir*min(pat,2)  
  pspr=flr(pat/2)%2+23
  if(not(b0 or b1))change_state(0)--go back to idle
  if(b2)change_state(3)--go to jump
  if(canfall())change_state(2)--drop if is in the air
 end

  --jump state
 if pstate==3 then
  pspr=21
  py-=6-pat
  if (b0) px-=2
  if (b1) px+=2
  if (not b2 or pat>7) change_state(0) end

 
 -- fall state
 if pstate==2 then
  pspr=22
  if (canfall()) then
   if (b0) px-=1
   if (b1) px+=1
   py+=min(4,pat) -- move the player
   if (not canfall()) py=flr(py/8)*8 -- check ground contact 
  else   
   py=flr(py/8)*8 -- fix position when we hit ground
   change_state(0)
  end
 end
end

function canfall()
 --step one, get map tile under player feet
 v = mget(flr((px+4)/8), flr((py+8)/8))
 --step two, see if it's flagged as wall
 return not fget(v,1)
end

--0 idle, 1 walk, 2 drop, 3 jump
function change_state(s)
 pstate=s
 pat=0
end


__gfx__
00000000077777000007770000077700077777000000000000000000000000000077770a00000000000000000000000000000000000000000000000000000000
00000000777777700077777000777770777777700000000000000000000000000777777a00000000000000000000000000000000000000000000000000000000
000000007fffff70077fff70077fff707fffff7000000000000000000000000007ffff7a00000000000000000000000000000000000000000000000000000000
00000000ff0f0f0007f0f07007f0f070ff0f0f00000000000000000000000000f7f0f07f00000000000000000000000000000000000000000000000000000000
00000000ffffff0a07ffff0007ffff00ffffff0a0000000000000000000000005fffff0000000000000000000000000000000000000000000000000000000000
000000005575550a00575000005750005575550a0000000000000000000000005057500000000000000000000000000000000000000000000000000000000000
000000005575505f05575f0005575f005575505f0000000000000000000000000557500000000000000000000000000000000000000000000000000000000000
00000000050500005560600055606000050500000000000000000000000000000060600000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000444440004444404044444000444440004444400000000000000000000000000c00c000000000000000000000000000
000000000000000007777000000777000444fff40444fff44444fff40444fff40444fff4000000000000c00000ccc0000c070700000000000000000000000000
00000000000000007777770000777770444f5f54444f5f54444f5f54444f5f54444f5f5400ccc70000007c000700070c0c000c00000000000000000000000000
000000000000000077fff700077fff7a44ff5f5444ff5f5444ff5f5444ff5f5444ff5f5400700c000000c0c000c00c000c0cc000000000000000000000000000
00000000000000007f0f070a07f0f07a44fffff044fffff004fffff044fffff040fffff000c00c000000c00000c70c0707007000000000000000000000000000
00000000000000007ffff0a007ffff0a0488f8004088f8008088f8000488f8008888f80007c07c00007cc00000000c0007000c00000000000000000000000000
000000000000000005575f000055755f00888800088888000888880088888800068888000c70cc0000cc7000000c70000c0c0c00000000000000000000000000
000000000000000006006000006006000886060086000060060000600060006000000600000000000000000000c000000c007000000000000000000000000000
0000000000000000000000000000000000444440004444404044444000444440004444400000000000000000000000000c00c000000000000000000000000000
000000000000000000000000000000000444fff40444fff54444fff40444fff40444fff4000000000000c00000c7c000070c0c00000000000000000000000000
0000000000000000000000000000000044455f5444455f5544455f5444455f5444455f54007ccc000000c7000c000c0c0c000c00000000000000000000000000
0000000000000000000000000000000044ffeef444ffeef544ffeef444ffeef444ffeef400c007000000c0c000c00c000c07c000000000000000000000000000
0000000000000000000000000000000044ffeef044ffeef004ffeef044ffeef040ffeef000c00c000000c000007c070c0c00c000000000000000000000000000
000000000000000000000000000000000488f80f4088f80f8088f80f0488f80f8888f80f0c70c70000c7c00000000c0007000700000000000000000000000000
00000000000000000000000000000000008888000888880008888800888888000688880007c07c00007cc0000007c000070c0c00000000000000000000000000
000000000000000000000000000000000886060086000060060000600060006000000600000000000000000000c000000c00c000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000cc000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000c00c00000000000cccccc000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000c0000c0000000000c0000c000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000c000000c0000000c0c0000c000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000c00000c0cc0000cccc0000cc000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000c000c00000000000c0000c0000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000c0c000000000000cccccc0000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000
11111117111111110001111100000000000000000000000008000000000000000007777700000000000000000000000000000000000000000000000000000000
111111111111111100017171000000000000000000000001110000000000000000777777000000000000000000000000000000000000000000000d0000dd0000
17111711171117110001111100000000000000000000001101000000000000000777777700000000000000000000000000000000000a000000dddddd0dd1ddd0
1111111111111111000171710000100000000080000001101110000000000000777777700000000000000000000a0000000a000000000000dddddd1ddd1ddddd
11171117111717110001111100011100000000100001111000000000000000007777700000000000000000000000000000000000000000000dd11ddddddddd1d
111111111111111100011111001111100000001000011110000000000000000777777000000000000000a00000000000000000000000000000ddd1d00dddd11d
17111711171117110001117181111118000011110000110000000000000000077777000000000000000000000000000000000000000000000000dd0000d0ddd0
111111111111111100011111111111110001111100811110000000000000007777000000000000000000000000000000000000a0000000000000000000000000
17171111111111110011111111111117001117110111711000000000000007777000000000000000000000000000000000000000000000000000000000000000
11111111111111110011111111111111001111110111111000000000001177700000000000000000000000000000000000000000000000a00000000000000000
11171117171117110011111117111711001117110111711000000000011777700000000000000000000000000000000000000000000000000000000000000000
111111111111111100111111111111110011111101111110000000001177700000000000000000000000000000000000000a0000000000000000000000000000
17111117111717110017111111171117001711110171111000000000117770000000000000000000000000000000000000000000000000000000000000000000
111111111111111100111111111111110011111101111110000000001117000000000000000000000000000000000000000000000000a0000000000000000000
11111117171117110011171117111711001117110111711000000000011100000000000000000000000000000000000000000a00000000000000000000000000
11111111111111110011111111111111001111110111111000000000011110000000000000000000000000000000000000000000000000000000000000000000
17171117171111110111111117171117011111110000000000000000111111171111111100000000000000000000000000000000000000000000000000000000
11111111111111110171111111111111017111110000000000000000111111111111111100000000000000000000000000000000000000000000000000000000
11171111171117110111711111171111011171110000000000000000171117111711171100000000000000000000000000000000000000000000000000000000
11111111111111110111111111111111011111110000000000000000111111111111111100000000000000000000000000000000000000000000000000000000
17111117111717110111717117111117011171710000000000000000111711171117171100000000000000000000000000000000000000000000000000000000
11111111111111110111111111111111011111110000000000000000111111111111111100000000000000000000000000000000000000000000000000000000
11171711111717110171711111171711017171110000000000000000171117111711171100000000000000000000000000000000000000000000000000000000
11111111111111110111111111111111011111110000000000000000111111111111111100000000000000000000000000000000000000000000000000000000
11111117111111111111111100000000000000000000000000000000171711111111111100000000000000000000000000000000000000000000000000000000
11111111111111111111111100000000000000000000000000000000111111111111111100000000000000000000000000000000000000000000000000000000
17111717171111111711111100000000000000000000080000000000111711171711171100000000000000000000000000000000000000000000000000000000
11111111111111111111111100001000000000000001110000000000111111111111111100000000000000000000000000000000000000000000000000000000
17111111111711111117111100011100008000000011010000000000171111171117171100000000000000000000000000000000000000000000000000000000
11111111111111111111111100111110001000000110010000000000111111111111111100000000000000000000000000000000000000000000000000000000
11171717171117111711171181111118011000001100111000000000111111171711171108000080000000000000000000000000000000000000000000000000
11111111111111111111111111111111111100001110000000000000111111111111111111111111000000000000000000000000000000000000000000000000
ddddddd7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111100000000000000
1ddddd7d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111117700000000
115555dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111117700000000
115555dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111117770000000
115555dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111117777700000
115555dd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111111777770000
1222225d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111111777777000
22222225000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111177777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111177777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111111111117777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111111111117777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111117777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111117777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111177777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111177777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111177777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111177777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111111111111111177777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077111111111111111111111777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077711111111111111111117777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777111111111111111177777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777711111111111111777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777711111111177777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777771111777777777777777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777777777777777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777777777777777777777770000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777777777700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777777777777000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777777777777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000cccccc000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000cccccc0c000000c00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000cccccc0c000000c0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000cccccc0c000000c000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000c000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000c00000000c00000000c00000000c000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000c00000000c00000000c00000000c00000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000c00000000c00000000c00000000c000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000c000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000cccccc0c000000c000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000cccccc0c000000c0000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000cccccc0c000000c00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000cccccc000000000000000000000000000000000000000000000000000000000
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

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0909094c0909094c4748094e4f09090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4f4e81814e4f8181575881818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
797909090909090968416f090909090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40416b6c5c6e4f4e606109095d6e6e8100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
50517b7c7d7e6e81406181818181818100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6061440505057e09686809090909090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70714205050505057850094e4f09090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6061629b05050581504181814473454600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7071727309090909505109095241410900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
404140416b6c6d80808009094041616b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
505150517b7c7d7e505181815051726b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
606160618b000000616181816061616b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
707170719b140000616109097071416b7b7b7b7b7b7b7b7b7b7b7b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808080808080808080808080808080807b7b7b7b7b7b7b7b7b7b7b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

