extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var horz_m = true
export var horz_way = 0
export var horz_range = 0
export var vert_m = true
export var vert_way = 0
export var vert_range = 0
export var falling = false
export var SPEED = 100
var x_range = 0
var y_range = 0
var velocity = Vector2(0,0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func get_velocity():
	return velocity

func _process(delta):
	var motion = Vector2(0,0)
	
	# X MOVING STUFF
	if horz_m == true:
		if horz_way == 0:
			motion+=Vector2(1,0)
		else:
			motion+=Vector2(-1,0)
	
	x_range += motion.x*delta*SPEED
	velocity.x = motion.x*delta*SPEED
	#
	
	if x_range >= horz_range:
		x_range = 0
		horz_way = 1
	if x_range <= -(horz_range):
		x_range = 0
		horz_way = 0
		
	# Y MOVING STUFF
	if vert_m == true:
		if vert_way == 0:
			motion+=Vector2(0,1)
		else:
			motion+=Vector2(0,-1)
	
	y_range += motion.y*delta*SPEED
	velocity.y = motion.y*delta*SPEED
	
	if y_range >= vert_range:
		y_range = 0
		vert_way = 1
	if y_range <= -(vert_range):
		y_range = 0
		vert_way = 0
			
	move(velocity)
