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
	
//gfx.print "Game Over!", 250, 200	
printMsg "Play Again? (Y/N)"	

while true
	if key.pressed("y") then
		reset; run "game"
	else if key.pressed("n") then
		clear
		print "Thanks!"	
		break
	end if
	yield
end while	
