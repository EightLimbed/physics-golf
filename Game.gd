extends Node2D

var vectors : Array[Vector2] = []
@onready var ball = $Ball

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		for i in vectors.size()-1:
			display_vector(vectors[i],vectors[i+1])
		if vectors.size() > 1:
			display_vector(vectors[0],vectors[vectors.size()-1])
		queue_redraw()

func display_vector(d1 : Vector2,d2 : Vector2):
	var label = Label.new()
	label.text = cartesian_to_kinematics(d1+d2)
	label.global_position = (d1+d2)/2
	add_child(label)

func cartesian_to_kinematics(df : Vector2):
	var dir = rad_to_deg(df.angle())
	if dir < 0:
		dir += 360
	if dir == 0:
		return str(round(df.length()/100))+"m [W]"
	elif 90 > dir and dir > 0:
		return str(round(df.length()/100))+"m [W "+str(dir)+"\u00B0 N]"
	elif dir == 90:
		return str(round(df.length()/100))+"m [N]"
	elif 180 > dir and dir > 90:
		return str(round(df.length()/100))+"m [N "+str(dir-90)+"\u00B0 E]"
	elif dir == 180:
		return str(round(df.length()/100))+"m [E]"
	elif 270 > dir and dir > 180:
		return str(round(df.length()/100))+"m [W "+str(dir)+"\u00B0 N]"
	elif dir == 270:
		return str(round(df.length()/100))+"m [S]"
	elif 360 > dir and dir > 270:
		return str(round(df.length()/100))+"m [N "+str(dir-90)+"\u00B0 E]"

func _draw() -> void:
	vectors.append(ball.position)
	if vectors.size() > 1:
		draw_polyline(vectors, Color.AQUAMARINE, 2, true)
		draw_line(vectors[0],ball.position, Color.BLUE, 4, true)
	vectors.remove_at(vectors.size()-1)
