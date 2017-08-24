extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var opcs = [0.2,0.4,0.6,0.8,1.0,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1]
var i
var timer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	timer = .025
	i=0
	set_process(true)
	pass

func _process(delta):
	if (timer < 0):
		timer = .025
		set_opacity(opcs[i])
		i+=1
		if (i==13):
			queue_free()
	else:
		timer-=delta