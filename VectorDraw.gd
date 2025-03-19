extends Node2D

func _ready() -> void:
	print(cartesian_to_kinematics(Vector2(100,100)))

func cartesian_to_kinematics(vec : Vector2):
	return str(round(vec.length()))+"m ["+str(round(rad_to_deg(vec.angle())))+"\u00B0]"
