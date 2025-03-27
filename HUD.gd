extends CanvasLayer

@export var levels : Array[PackedScene]
@onready var ball = get_parent().get_node("Ball")
var current_level = -1

func display_shots(vectors : Array[String]):
	var display = ""
	for v in vectors:
		display += v+"\n"
	$Shots.text = display+str(get_parent().total_displacement())

func display_launches(vectors : Array[String]):
	var display = ""
	for v in vectors:
		display += v+"\n"
	$Launches.text = display

func display_bounces(vectors : Array[String]):
	var display = ""
	for v in vectors:
		display += v+"\n"
	$Bounces.text = display

func level_completed():
	$LevelComplete.text = "Level Completed in "+str(ball.shot)+" Shots. Good Job!"
	$LevelComplete.show()
	$Button.show()

func _on_button_pressed() -> void:
	current_level += 1
	$Shots.text = ""
	$Launches.text = ""
	$Bounces.text = ""
	if current_level > levels.size()-1:
		get_tree().change_scene_to_file("res://WinScreen.tscn")
	else:
		$LevelComplete.hide()
		$Button.hide()
		get_parent().reset()
		ball.reset()
		get_parent().get_child(get_parent().get_child_count()-1).queue_free()
		get_parent().add_child(levels[current_level].instantiate())
