// Dec 9, 2025, A menu module to import into any game

import "bmfFonts"

// added Feb 2 for Git testing...

clear
gfx.drawImage file.loadImage("assets/over_background.png")

mouse.visible = false
mouseSelected = false // if true, move with the mouse, gamepad otherwise.
gamepadSelected = false

f = bmfFonts.Font.load("/sys/fonts/minimicro-pro-20.bmf")

line1 = "BALLOONS A-POPPING!"
line2 = "Press g to use gameypad or keyboard"
line3 = "Press m to use the mouseyload"

lgScale = 2
smScale = 1.5

width1 = f.width(line1, lgScale)
width2 = f.width(line2, smScale)
width3 = f.width(line3, smScale)

f.print(
	line1,
	(480 - width1 / 2),
	400,
	lgScale,
	"#0000FFFF")
f.print(
	line2,
	(480 - width2 / 2),
	200,
	smScale,
	"#8F05FFFF")
f.print(
	line3,
	(480 - width3 / 2),
	150,
	smScale,
	"#8F05FFFF")

// {
transition = function
	// Fade out
	display(0).mode = displayMode.solidColor
	d = display(0)
	for a in range(5, 255, 25)
		d.color = color.rgba(
			0,
			0,
			0,
			a)
		yield
	end for
	// run the game module
	run "game"
end function
// }
while true
	if key.pressed("m") then // use the mouse
		mouseSelected = true
		transition
	else if key.pressed("g") then // use the keyboard or gamepad
		gamepadSelected = true
		transition
	end if
	if key.pressed("escape") then
		clear
		print "Thanks for playing!"
		break
	end if
	yield
end while


