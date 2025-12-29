// Nov 11, 2025 - Balloon popping game by Peter
// pop balloons all day long, press Esc to quit.
// mostly borrowed from the demos and modified .

import "myTextUtils"
import "mathUtil"

clear   
gfx.drawImage file.loadImage("assets/background1.png")

display(4).mode = displayMode.sprite
disp = display(4)
disp.clear

mouse.visible = false // Hide the mouse cursor

popping = file.loadSound("/sys/sounds/pop.wav")
burstImg = file.loadImage("/sys/pics/Burst.png")

// A sprite for the crosshairs
Sight = new Sprite
Sight.image = file.loadImage("assets/crosshair.png")
Sight.localBounds = new Bounds
Sight.localBounds.width = Sight.image.width
Sight.localBounds.height = Sight.image.height

Sight.x = 480 // start in the center
Sight.y = 320
Sight.speed = 10 // pixels to move per frame
Sight.tint = color.green
disp.sprites.push Sight

Sight.update = function()
	// key.axis works for the gamepad, keyboard arrows and WASD.
	dx = key.axis("Horizontal") //or mouse.x
	dy = key.axis("Vertical") //or mouse.y
	dlen = sqrt(dx*dx + dy*dy) // normalize diagonal movement
	if dlen > 1 then
		dx = dx / dlen
		dy = dy / dlen
	end if
	// move the sprite
	Sight.x += dx * Sight.speed
	Sight.y += dy * Sight.speed	
end function

//==================================================
// Balloon class
//==================================================
Balloon = new Sprite
Balloon.image = file.loadImage("/sys/pics/Balloon.png")
//Balloon.image = file.loadImage("assets/3.png")
Balloon.localBounds = new Bounds
Balloon.localBounds.width = Balloon.image.width
Balloon.localBounds.height = Balloon.image.height
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
		self.tint =  "#FF0000C0"//color.red
		self.scale = 0.9
		self.speed = 0.9
	end if
	disp.sprites.push self
end function

// remove a balloon from the list and the display
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
	popping.play // popping sound
	self.image = burstImg
	// minus value will use the balloon colour
	self.tint = color.lerp(self.tint, color.white, -0.7)
	self.rotation = 360*rnd // add variety to the bursts
	self.burstTime = time	
end function

// score
score = {}
score.value = 0

score.print = function
	myTextUtils.eraseText 25, 2, "SCORE: 999999".len
	myTextUtils.printTextAtPosition "SCORE: "+ self.value, 25, 2, color.yellow	
end function
score.print // print the empty score to start

// game timer
endTime = time + 10
updateTime = function()
	timeLeft = ceil(endTime - time)
	text.row = 25
	text.column = 58
	if timeLeft<= 0 then
		text.color = color.red
		print "TIME'S UP!"
		text.color = color.silver
		//gameOver
		reset
		run "over"
	else
		mins = floor(timeLeft/60)
		secs = ("00" + (timeLeft % 60))[-2:]
		print "TIME: " + mins + ":" + secs
	end if	
end function

// collision detection using the mouse
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

checkOverlap = function	
	for b in balloons
		if Sight.overlaps(b) and key.pressed("joystick button 1") then
			b.pop
			wait 0.1 // See the burst image
			b.remove
			score.value += 1	
			score.print				
		end if
	end for
end function

balloons = [] // a list to hold many balloons
hadMouseDown = mouse.button
lastTime = time

// ********************* Game Loop ***********************
while not key.pressed("escape")  
	
	dt = time - lastTime
	lastTime = time	
	
	// make a new balloon now and then
	if rnd < 0.02 then
		b = new Balloon
		b.init
		balloons.push b
	end if	
	
	// move the crosshairs with the mouse
	//mathUtil.moveTowardsXY Sight, mouse, 20
	
	// handle mouse clicks
	mouseDown = mouse.button
	if mouseDown and not hadMouseDown then 		
		handleClick mouse		
		//Sight.update
	end if
	
	hadMouseDown = mouseDown
	
	checkOverlap
	
	// update the balloons	
	for b in balloons
		b.update dt
	end for	
	
	// move the crosshairs by gamepad or keys
	Sight.update	
	
	updateTime
	
	yield  // (wait till next frame)  
	
end while

clear