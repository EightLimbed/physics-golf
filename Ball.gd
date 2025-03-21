extends RigidBody2D

@onready var game = get_parent()
var launch_ready : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.vectors.append(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_released("Launch") and launch_ready:
		apply_central_impulse(-get_local_mouse_position()*2)
		launch_ready = false

func _on_body_entered(_body: Node) -> void:
	game.vectors.append(position)
	print(game.vectors)

func _on_mouse_entered() -> void:
	if Input.is_action_pressed("Launch"):
		print("entered")
		launch_ready = true

func _draw() -> void:
	if launch_ready:
		draw_line(position, get_local_mouse_position(), Color.YELLOW, 6, true)
