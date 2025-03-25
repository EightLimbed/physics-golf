extends Node2D

var target : Vector2 = Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.hit_goal($Area2D.position)
	get_parent().get_node("HUD").level_completed()
