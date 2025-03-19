extends RigidBody2D

@onready var game = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("Launch"):
		apply_central_impulse(-get_local_mouse_position())

func _on_body_entered(_body: Node) -> void:
	game.vectors.append(position)
	print(game.vectors)
