// Dec 11, 2025, A game over module to import into any game

import "background"
import "bmfFonts"

clear
background.drawBackground

f = bmfFonts.Font.load("/sys/fonts/minimicro-pro-20.bmf")
//f = bmfFonts.Font.load("/sys/fonts/Arial14Bold.bmf")

line1 = "Game Over"
line2 = "Play Again? (Y/N)"
line3 = "Your score was: " + score.value

scale = 1.5
width1 = f.width(line1, scale)
width2 = f.width(line2, scale)
width3 = f.width(line3, scale)
//print width


f.print line1, (480-width1/2), 400, scale, "#ff0000"
f.print line2, (480-width2/2), 300, scale, "#ff0000"
f.print line3, (480-width3/2), 200, scale, "#ff0000"
// 
// printMsg = function(s)
// text.row = 3
// text.color = "#EFAA2E"
// text.column = 34 - s.len/2
// print s
// end function

//gfx.print "Game Over!", 250, 300	
//gfx.print "Play Again? (Y/N)", 250, 200
//text.row = 10
//gfx.print "Your score was: " + score.value, 250, 250

while true
	if key.pressed("y") then
		load "game"; run
	else if key.pressed("n") then
		clear
		print "Thanks!"	
		break
	end if
	yield
end while	