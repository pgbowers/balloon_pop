// Nov 11, 2025 - Balloon popping game by Peter
// pop balloons all day long, press Esc to quit.
// mostly borrowed from the demos and modified .

import "mathUtil"

clear
gfx.clear "#004400" // green background

display(4).mode = displayMode.sprite
disp = display(4)
disp.clear

pop = file.loadSound("/sys/sounds/pop.wav")
burstImg = file.loadImage("/sys/pics/Burst.png")

//==================================================
// Balloon class
//==================================================
Balloon = new Sprite
Balloon.image = file.loadImage("/sys/pics/Balloon.png")
Balloon.burstTime = null
Balloon.init = function	
	self.x = floor(rnd * 928) //random left to right
	if self.x < 40 then // stay on the screen to the left
		self.x = 40
	end if	
	
	self.y = 710 // start above the top of the screen	
	
	// random sizes, speeds and colours
	type = floor(rnd*5)
	if type == 0 then
		self.tint = color.yellow
		self.scale = 1.1
		self.speed = 2
	else if type == 1 then
		self.tint = color.blue
		self.speed = 1.5
	else if type == 2 then
		self.tint = color.purple
		self.speed = 3
		self.scale = 2
	else if type == 3 then
		self.tint = color.orange
		self.speed = 1
		self.scale = 2		
	else
		self.tint = color.red
		self.scale = 0.9
		self.speed = 0.9
	end if
	disp.sprites.push self
end function

// remove from the list and the display
Balloon.remove = function
	disp.sprites.remove disp.sprites.indexOf(self)
	balloons.remove balloons.indexOf(self)
end function

Balloon.update = function(dt=0.1)
	if self.burstTime then
		if time - self.burstTime > 0.1 then self.remove
		return
	end if	
	self.y = self.y - self.speed // move the ballons straight down
	
	// remove when hitting the bottom
	if self.y == 32 then self.remove
end function

Balloon.pop = function
	pop.play
	self.image = burstImg
	// minus value will use the balloon colour
	self.tint = color.lerp(self.tint, color.white, -0.7)
	self.rotation = 360*rnd
	self.burstTime = time	
end function

// score
score = {}
score.value = 0

// text helper functions for the score
eraseText = function(row, column, length)
	text.row = row
	text.column = column
	print " " * length, ""
end function

printTextAtPosition = function(txt, row, column, txtColor)
	// save the current color and set the one passed as a parameter
	previousColor = text.color
	text.color = txtColor
	// move to postiton and print the text
	text.row = row
	text.column = column
	print txt
	// restore the previous color
	text.color = previousColor	
end function

score.print = function
	eraseText 25, 2, "SCORE: 999999".len
	printTextAtPosition "SCORE: "+ self.value, 25, 2, color.white	
end function
score.print // print the empty score to start

//==================================================
// Main program
//==================================================

handleClick = function(pos)
	// check for a click on a balloon
	for b in balloons
		if mathUtil.distance(b, pos) < 32 then
			b.pop				
			score.value += 1	
			score.print		
			return			
		end if
	end for	
end function

balloons = [] // a list to hold many balloons
hadMouseDown = mouse.button
lastTime = time
while not key.pressed("escape")
	dt = time - lastTime
	lastTime = time
	
	// make a new balloon now and then
	if rnd < 0.02 then
		b = new Balloon
		b.init
		balloons.push b
	end if
	
	// handle mouse clicks
	mouseDown = mouse.button
	if mouseDown and not hadMouseDown then 		
		handleClick mouse		
	end if
	
	hadMouseDown = mouseDown
	
	// update the balloons	
	for b in balloons
		b.update dt
	end for
	
	yield  // (wait till next frame)
end while
key.clear