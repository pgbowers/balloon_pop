// Dec 9 - A game background

drawBackground = function
	gfx.clear color.clear
	
	display(7).mode = displayMode.pixel
	bkgnd = display(7)
	bkgnd.clear color.black, gfx.width, gfx.height
	bkgnd.scale = gfx.scale
	for y in range(0, bkgnd.height - 1)
		c = color.lerp("#550055", "#000022", y/bkgnd.height)
		bkgnd.line 0, y, bkgnd.width, y, c	
	end for	
end function
