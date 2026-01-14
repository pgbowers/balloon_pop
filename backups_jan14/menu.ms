// Dec 9, 2025, A menu module to import into any game

import "bmfFonts"

clear
gfx.drawImage file.loadImage("assets/over_background.png")

mouse.visible = false
mouseSelected = false // if true, move with the mouse, gamepad otherwise.
gamepadSelected = false

f = bmfFonts.Font.load("/sys/fonts/minimicro-pro-20.bmf")

line1 = "BALLOONS A-POPPING!"
line2 = "Press g to use gamepad or keyboard"
line3 = "Press m to use the mouse"

lgScale = 2.0
smScale = 1.5

width1 = f.width(line1, lgScale)
width2 = f.width(line2, smScale)
width3 = f.width(line3, smScale)

f.print line1, (480-width1/2), 400, lgScale, "#0000FFFF"
f.print line2, (480-width2/2), 200, smScale, "#8F05FFFF"
f.print line3, (480-width3/2), 150, smScale, "#8F05FFFF"

while true                   
	if key.pressed("s") or key.pressed("joystick button 7") then
		load "game"; run
	else if key.pressed("escape") then
		clear
		print "Thanks for playing!"	
		break
	end if
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
