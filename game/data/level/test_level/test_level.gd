extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spawn_point
var check_point = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	spawn_point = get_node("player").get_pos()
	set_process(true)
	pass
	
func _process(delta):
	if (get_node("player").get_pos().y > 700):
		get_node("player").set_pos(spawn_point)
	get_node("player/Camera2D").align()


func _on_a2d_checkpoint_area_enter( area ):
	pass # replace with function body


func _on_a2d_checkpoint_body_enter( body ):
	if (check_point < get_node("Checkpoints/checkpoint1").checkpoint_num):
		check_point = get_node("Checkpoints/checkpoint1").checkpoint_num
		spawn_point = get_node("Checkpoints/checkpoint1").get_pos()


func _on_a2d_checkpoint1_body_enter( body ):
	if (check_point < get_node("Checkpoints/checkpoint2").checkpoint_num):
		check_point = get_node("Checkpoints/checkpoint2").checkpoint_num
		spawn_point = get_node("Checkpoints/checkpoint2").get_pos()
