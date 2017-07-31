extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var scene_length = 0
export var scene_auto = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func get_scene_length():
	return scene_length

func get_scene_auto():
	return scene_auto
