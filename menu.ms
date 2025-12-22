// Dec 9, 2025, A menu module to import into any game

import "background"

clear
background.drawBackground	

printMsg = function(s)
	text.row = 3
	text.color = "#EFAA2E"
	text.column = 34 - s.len/2
	print s
end function

//printMsg "This is the Menu"
printMsg "Press S to start the game"	

while not key.pressed("s")
	yield
end while

// Fade out
display(0).mode = displayMode.solidColor
d = display(0)
for a in range(5, 255, 25)
	d.color = color.rgba(0, 0, 0, a)
	yield
end for

reset
run "game"
