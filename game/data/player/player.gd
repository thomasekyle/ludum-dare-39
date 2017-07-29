extends KinematicBody2D
#Member Variables

#Physics
var grav=1700

#Player Variables
var JUMP_FORCE=500
var SPEED=100
var ACCELERATION=500
var DECCELERATION=900
var MAX_SPEED=250
var speed_x=0
var speed_y=0
var velocity=Vector2()
var input_direction=0
var direction=0
var flip=false
var falling=true
var jumps=2
var moving=false
var move_remainder
var shadow = 0.1

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if (event != null):
		moving=true
	else:
		moving=false
	if (Input.is_action_pressed("ui_accept") and jumps > 0):
		speed_y = -JUMP_FORCE
		jumps-=1

func _process(delta):
	
		
	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_left"):
		get_node("anim_player").set_animation("moving")
		get_node("anim_player").set_flip_h(true)
		input_direction = -1
	elif Input.is_action_pressed("ui_right"):
		get_node("anim_player").set_animation("moving")
		get_node("anim_player").set_flip_h(false)
		input_direction = 1
	else:
		input_direction = 0
		get_node("anim_player").set_animation("default")
	
	if input_direction !=  direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECCELERATION * delta
		
	speed_x = clamp(speed_x, 0 , MAX_SPEED)
		
	#Add Gravity
	speed_y += grav * delta
	if jumps < 2:
		get_node("anim_player").set_animation("jumping")
	
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	move_remainder = move(velocity)
	
       
	
	if is_colliding():
		var normal = get_collision_normal()
		if normal.y < 0:
			jumps = 2
			grav = 0
		var slide = normal.slide(move_remainder)
		speed_y = normal.slide(Vector2(0, speed_y))
		speed_y = 0
		var obj = get_collider()
		var add_vel = get_col_vel(obj)
		if moving:
			move(slide)
		else:
			move(add_vel)
	else:
		grav = 1700
			
		
func get_col_vel(o):
	var cols = get_parent().get_node("Platforms").get_children()
	for i in cols:
		if (i.get_instance_ID() == o.get_instance_ID()):
			return i.get_velocity()
			
			