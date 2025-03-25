extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.hit_goal()
	get_parent().get_node("HUD").level_completed()
