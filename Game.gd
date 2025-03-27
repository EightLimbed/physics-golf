extends Node2D

var vectors : Array[Vector2] = []
var vectors_totals : Array[Vector2] = []
var vectors_kinematics : Array[String] = []
var vectors_kinematics_totals : Array[String] = []
@onready var ball = $Ball

func update_vectors_display(): 
	queue_redraw()
	$HUD.display_shots(vectors_kinematics_totals)
	$HUD.display_bounces(vectors_kinematics)

func update_shot_summary():
	for i in (vectors.size()-vectors_kinematics.size())-1:
		vectors_kinematics.append(cartesian_to_kinematics(vectors[i+vectors_kinematics.size()+1]-vectors[i+vectors_kinematics.size()], ball.shot))
	for i in (vectors_totals.size()-vectors_kinematics_totals.size())-1:
		vectors_kinematics_totals.append(cartesian_to_kinematics(vectors_totals[i+vectors_kinematics_totals.size()+1]-vectors_totals[i+vectors_kinematics_totals.size()], ball.shot))

func reset():
	update_vectors_display()
	vectors = []
	vectors_totals = []
	vectors_kinematics = []
	vectors_kinematics_totals  = []

func cartesian_to_kinematics(df : Vector2, shot = "total"):
	var dir = rad_to_deg(df.angle())
	if dir < 0:
		dir += 360
	if round(dir) == 0:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [E]"
	elif 90 > dir and dir > 0:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [E "+str(round(dir))+"\u00B0 S]"
	elif round(dir) == 90:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [S]"
	elif 180 > dir and dir > 90:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [S "+str(round(dir-90))+"\u00B0 W]"
	elif round(dir) == 180:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [W]"
	elif 270 > dir and dir > 180:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [W "+str(round(dir-180))+"\u00B0 N]"
	elif round(dir) == 270:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [N]"
	elif 360 > dir and dir > 270:
		return "Shot "+str(shot)+": "+str(round(df.length())/10)+"m [N "+str(round(dir-270))+"\u00B0 E]"

func _draw() -> void:
	vectors.append(ball.position)
	vectors_totals.append(ball.position)
	if vectors.size() > 1:
		for i in vectors.size()-1:
			if round(i/2.0) == i/2.0:
				draw_line(vectors[i], vectors[i+1], Color.AQUAMARINE, 2, true)
			else:
				draw_line(vectors[i], vectors[i+1], Color.GREEN, 2, true)
			draw_line(vectors[i]-Vector2(32,0),vectors[i]+Vector2(32,0), Color.BLACK, 1, true)
			draw_line(vectors[i]-Vector2(0,32),vectors[i]+Vector2(0,32), Color.BLACK, 1, true)
	if vectors_totals.size() > 1:
		for i in vectors_totals.size()-1:
			if round(i/2.0) == i/2.0:
				draw_line(vectors_totals[i], vectors_totals[i+1], Color.BLUE, 4, true)
			else:
				draw_line(vectors_totals[i], vectors_totals[i+1], Color.DARK_BLUE, 4, true)
			draw_line(vectors_totals[i]-Vector2(32,0),vectors_totals[i]+Vector2(32,0), Color.BLACK, 1, true)
			draw_line(vectors_totals[i]-Vector2(0,32),vectors_totals[i]+Vector2(0,32), Color.BLACK, 1, true)
	vectors.remove_at(vectors.size()-1)
	vectors_totals.remove_at(vectors_totals.size()-1)
	draw_line(vectors_totals[0]-Vector2(32,0),vectors_totals[vectors_totals.size()-1]+Vector2(32,0), Color.HOT_PINK, 1, true)

func total_displacement():
	return cartesian_to_kinematics(vectors_totals[0]-vectors_totals[vectors_totals.size()-1])
