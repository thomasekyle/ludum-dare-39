extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spawn_point = Vector2(0,0)
var checkpoint = 0
var difficulty = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func set_spawn_point(p):
	spawn_point = p
