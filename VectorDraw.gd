extends Node2D

func _ready() -> void:
	print(cartesian_to_kinematics(Vector2(100,100)))

func cartesian_to_kinematics(vec : Vector2):
	var dir = round(rad_to_deg(vec.angle()))
	if dir == 0:
		return str(round(vec.length())+"m [W]")
	elif 90 > dir and dir > 0:
		return str(round(vec.length()))+"m [W "+str(dir)+"\u00B0 N]"
	elif dir == 90:
		return str(round(vec.length())+"m [N]")
	elif 180 > dir and dir > 90:
		return str(round(vec.length()))+"m [N "+str(dir-90)+"\u00B0 E]"
	elif dir == 180:
		return str(round(vec.length())+"m [E]")
	elif 270 > dir and dir > 180:
		return str(round(vec.length()))+"m [W "+str(dir)+"\u00B0 N]"
	elif dir == 270:
		return str(round(vec.length())+"m [S]")
	elif 360 > dir and dir > 90:
		return str(round(vec.length()))+"m [N "+str(dir-90)+"\u00B0 E]"
