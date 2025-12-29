// Dec 11, 2025, A game over module to import into any game

import "background"

clear
background.drawBackground

printMsg = function(s)
	text.row = 3
	text.color = "#EFAA2E"
	text.column = 34 - s.len/2
	print s
end function

gfx.print "Game Over!", 250, 300	
gfx.print "Play Again? (Y/N)", 250, 200
//text.row = 10
gfx.print "Your score was: " + score.value, 250, 250

while true
	if key.pressed("y") then
		//reset; run "game"
		run "game"
	else if key.pressed("n") then
		clear
		print "Thanks!"	
		break
	end if
	yield
end while	
