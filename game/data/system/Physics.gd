extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var moving = false
var entity

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_player_moving(m):
	moving = m

func is_player_moving():
	return moving
