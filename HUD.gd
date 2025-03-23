extends CanvasLayer

func display_holes(vectors : Array[String]):
	var display = ""
	for v in vectors:
		display += v+"\n"
	$Holes.text = display
