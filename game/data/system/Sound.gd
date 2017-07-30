extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sfx = preload("res://data/audio/sfx/sfx.tscn")
var sfx_player
var bgm = preload("res://data/audio/bgm/bgm.tscn")
var bgm_player

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	sfx_player = sfx.instance()
	bgm_player = bgm.instance()
	
func play(s):
	sfx_player.play(s)
	
func set_bgm(f):
	bgm_player.play(f)
	
func change_bgm_vol(v):
	bgm_player.set_volume(v)
