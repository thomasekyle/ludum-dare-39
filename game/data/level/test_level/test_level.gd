extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spawn_point
var check_point = 0
var shadow_timer = 0
var GLOBAL_BAR_POS

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	spawn_point = get_node("player").get_pos()
	GLOBAL_BAR_POS = get_node("player/ui/shadow_bar/bar").get_pos()
	set_process(true)
	pass
	
func _process(delta):
	if (get_node("player").get_pos().y > 700):
		get_node("player").set_pos(spawn_point)
	get_node("player/Camera2D").align()
	
	
	
	if shadow_timer > .25 :
		shadow_timer = 0
		var opc = get_node("player/shadow_overlay").get_opacity() + 0.01
		var light_length = get_node("player/ui/shadow_bar/bar").get_scale().x - 0.00318
		if opc < 0.85:
			get_node("player/ui/shadow_bar/bar").set_scale(Vector2(light_length, 0.21))
			get_node("player/shadow_overlay").set_opacity(opc)
	else:
		shadow_timer += delta


func _on_a2d_checkpoint_area_enter( area ):
	pass # replace with function body


func _on_a2d_checkpoint_body_enter( body ):
	get_node("player/shadow_overlay").set_opacity(0.1)

	get_node("player/ui/shadow_bar/bar").set_scale(Vector2(0.26,0.21))
	if (check_point < get_node("Checkpoints/checkpoint1").checkpoint_num):
		check_point = get_node("Checkpoints/checkpoint1").checkpoint_num
		spawn_point = get_node("Checkpoints/checkpoint1").get_pos()


func _on_a2d_checkpoint1_body_enter( body ):
	get_node("player/shadow_overlay").set_opacity(0.1)
	get_node("player/ui/shadow_bar/bar").set_scale(Vector2(0.26,0.21))
	if (check_point < get_node("Checkpoints/checkpoint2").checkpoint_num):
		check_point = get_node("Checkpoints/checkpoint2").checkpoint_num
		spawn_point = get_node("Checkpoints/checkpoint2").get_pos()
