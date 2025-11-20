// Nov 14,2025 - text helper functions - Peter

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