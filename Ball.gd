extends RigidBody2D

@onready var game = get_parent()
var launch_ready : bool = false
var shot : int = 0

func _ready() -> void:
	reset(Vector2(0,0))

func hit_goal():
	linear_velocity = Vector2.ZERO
	game.vectors_totals.append(position)
	game.update_shot_summary()

func reset(pos):
	linear_velocity = Vector2.ZERO
	game.vectors.append(position)
	game.vectors_totals.append(position)

func _process(_delta: float) -> void:
	if linear_velocity.length() < 64 or linear_velocity.length() < -64:
		if linear_velocity != Vector2.ZERO:
			game.vectors_totals.append(position)
			game.update_shot_summary()
		linear_velocity = Vector2.ZERO
	if launch_ready:
		queue_redraw()
		$Label.show()
		$Sprite2D2.show()
		$Sprite2D2.position = -get_local_mouse_position()
		$Sprite2D2.rotation = get_local_mouse_position().angle()-PI/2
		$Label.text = cartesian_to_kinematics(-get_local_mouse_position())
	else:
		$Label.hide()
		$Sprite2D2.hide()
		game.update_vectors_display()

func _on_body_entered(_body: Node) -> void:
	game.vectors.append(position)
	game.update_shot_summary()

func _draw() -> void:
	if launch_ready:
		draw_line(Vector2.ZERO, -get_local_mouse_position(), Color.YELLOW, 6, true)

func cartesian_to_kinematics(df : Vector2):
	var dir = rad_to_deg(df.angle())
	if dir < 0:
		dir += 360
	if round(dir) == 0:
		return str(round(df.length()/10)/10)+"m/s [E]"
	elif 90 > dir and dir > 0:
		return str(round(df.length()/10)/10)+"m/s [E "+str(round(dir))+"\u00B0 S]"
	elif round(dir) == 90:
		return str(round(df.length()/10)/10)+"m/s [S]"
	elif 180 > dir and dir > 90:
		return str(round(df.length()/10)/10)+"m/s [S "+str(round(dir-90))+"\u00B0 W]"
	elif round(dir) == 180:
		return str(round(df.length()/10)/10)+"m/s [W]"
	elif 270 > dir and dir > 180:
		return str(round(df.length()/10)/10)+"m/s [W "+str(round(dir-180))+"\u00B0 N]"
	elif round(dir) == 270:
		return str(round(df.length()/10)/10)+"m/s [N]"
	elif 360 > dir and dir > 270:
		return str(round(df.length()/10)/10)+"m/s [N "+str(round(dir-270))+"\u00B0 E]"

func _on_texture_button_button_down() -> void:
	if linear_velocity == Vector2.ZERO:
		launch_ready = true

func _on_texture_button_button_up() -> void:
	if linear_velocity == Vector2.ZERO and launch_ready:
		if round(get_local_mouse_position().length()) > 0:
			shot += 1
			apply_central_impulse(-get_local_mouse_position()*2)
			queue_redraw()
		launch_ready = false
