// Dec 11, 2025, A game over module to import into any game

import "bmfFonts"

clear

gfx.drawImage file.loadImage("assets/over_background.png")

f = bmfFonts.Font.load("/sys/fonts/minimicro-pro-20.bmf")
//f = bmfFonts.Font.load("/sys/fonts/Arial14Bold.bmf")

line1 = "Game Over!"
line2 = "Play Again? (Y/N)"
line3 = "Your score was: " + score.value

lgScale = 2.0
smScale = 1.5
width1 = f.width(line1, lgScale)
width2 = f.width(line2, smScale)
width3 = f.width(line3, smScale)

f.print line1, (480-width1/2), 400, lgScale, "#0000FFFF"
f.print line2, (480-width2/2), 200, smScale, "#8F05FFFF"
f.print line3, (480-width3/2), 350, smScale, "#FF8C00FF"

while true
	if key.pressed("y") or key.pressed("joystick button 3") then
		load "game"; run
	else if key.pressed("n") or key.pressed("joystick button 2") then
		clear
		print "Thanks for playing!"	
		break
	end if
	yield
end while	