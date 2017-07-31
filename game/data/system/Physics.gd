extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var moving = false
var entity
var attack = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_attack(t):
	attack = t

func get_attack():
	return attack

func set_player_moving(m):
	moving = m

func is_player_moving():
	return moving
