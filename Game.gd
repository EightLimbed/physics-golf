extends Node2D

var vectors : Array[Vector2] = []
var vectors_kinematics : Array[String] = []
@onready var ball = $Ball

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		for i in vectors.size()-1:
			display_vector(vectors[i],vectors[i+1])
		if vectors.size() > 1:
			display_vector(vectors[0],vectors[vectors.size()-1])
		queue_redraw()

func display_vector(d1 : Vector2,d2 : Vector2):
	vectors_kinematics.append(cartesian_to_kinematics(d1+d2))
	#var label = Label.new()
	#label.text = cartesian_to_kinematics(d1+d2)
	#label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#add_child(label)

func cartesian_to_kinematics(df : Vector2):
	var dir = rad_to_deg(df.angle())
	if dir < 0:
		dir += 360
	if round(dir) == 0:
		return str(round(df.length()/100))+"m [W]"
	elif 90 > dir and dir > 0:
		return str(round(df.length()/100))+"m [E "+str(round(dir))+"\u00B0 S]"
	elif round(dir) == 90:
		return str(round(df.length()/100))+"m [S]"
	elif 180 > dir and dir > 90:
		return str(round(df.length()/100))+"m [S "+str(round(dir-90))+"\u00B0 W]"
	elif round(dir) == 180:
		return str(round(df.length()/100))+"m [E]"
	elif 270 > dir and dir > 180:
		return str(round(df.length()/100))+"m [W "+str(round(dir-180))+"\u00B0 N]"
	elif round(dir) == 270:
		return str(round(df.length()/100))+"m [N]"
	elif 360 > dir and dir > 270:
		return str(round(df.length()/100))+"m [N "+str(round(dir-270))+"\u00B0 E]"

func _draw() -> void:
	vectors.append(ball.position)
	if vectors.size() > 1:
		for i in vectors.size()-1:
			if round(i/2.0) == i/2.0:
				draw_line(vectors[i], vectors[i+1], Color.AQUAMARINE, 2, true)
			else:
				draw_line(vectors[i], vectors[i+1], Color.GREEN, 2, true)
		draw_line(vectors[0],ball.position, Color.BLUE, 4, true)
	vectors.remove_at(vectors.size()-1)
