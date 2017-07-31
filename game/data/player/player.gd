extends KinematicBody2D
#Member Variables

#Physics
var grav=1000

#Player Variables
var invincible = false
var i_timer = 0
var flash_timer = 0
var JUMP_FORCE=350
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
var jumps=1
var moving=false
var move_remainder
var shadow = 0.1
var d = 0.01668
var spring = false
var up_pushed = false

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if (Input.is_action_pressed("ui_up")):
		up_pushed = true
	else:
		up_pushed = false
	if (event != null):
		moving=true
	else:
		moving=false
	if (Input.is_action_pressed("ui_accept") and jumps > 0):
		speed_y = -JUMP_FORCE
		Sound.play("jump")
		jumps-=1

func _process(delta):
	if (Input.is_action_pressed("ui_up")):
		up_pushed = true
	else:
		up_pushed = false
		
	if (i_timer > 0):
		if (flash_timer > 0):
			flash_timer-=delta
			get_node("anim_player").hide()
		else:
			get_node("anim_player").show()
			i_timer-=1
			flash_timer = .125
		
	else:
		invincible == false
		JUMP_FORCE = 350
		show()
		
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
	if jumps < 1:
		get_node("anim_player").set_animation("jumping")
	speed_y = clamp(speed_y, -800 , 1700)
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	move_remainder = move(velocity)
	
       
	
	if is_colliding():
		var normal = get_collision_normal()
		if normal.y < 0:
			if jumps < 1:
				Sound.play("landing")
			jumps = 1
			grav = 0

			
		var slide = normal.slide(move_remainder)
		speed_y = normal.slide(Vector2(0, speed_y)).y
		#speed_y = 0
		if moving:
			move(slide)
			
	else:
		grav = 1000
			
		
func get_col_vel(o):
	var cols = get_parent().get_node("Platforms").get_children()
	for i in cols:
		if (i.get_instance_ID() == o.get_instance_ID()):
			return i.get_velocity()
			
			