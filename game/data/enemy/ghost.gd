extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim_itmer=5
var timer
var direction = Vector2(0,0)
var attack = false
var x_dir
var y_dir
var speed = 300

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass 
	
func _process(delta):
	if (attack == true and timer < 1):
		get_node("anim_ghost").set_animation("default")
		var hero_pos = get_parent().get_node("player").get_pos()
		if hero_pos.x > get_pos().x:
			x_dir = 1
		else:
			x_dir = -1
		if hero_pos.y > get_pos().y:
			y_dir = 1
		else:
			y_dir = -1
		direction.x = x_dir
		direction.y = y_dir
		var pos = get_pos()
		pos+=speed*direction*delta
		Physics.set_attack(true)
		set_pos(pos)
	if (timer > 0):
		timer-=delta
	else:
		Physics.set_attack(false)
		queue_free()
	

func attack(pos):
	timer = 2
	attack=true
	set_process(true)
	set_opacity(0.25)
	get_node("anim_ghost").set_animation("flicker")
	var rand_x=randi()%400-200
	var rand_y=randi()%400-200
	var new_pos = pos + Vector2(rand_x,rand_y)
	set_pos(new_pos)
	pass
	
func scare(pos):
	timer = 4
	set_process(true)
	set_opacity(0.25)
	get_node("anim_ghost").set_animation("flicker")
	var rand_x=randi()%400-200
	var rand_y=randi()%400-200
	var new_pos = pos + Vector2(rand_x,rand_y)
	set_pos(new_pos)
	
	
func flash_attack():
	pass
