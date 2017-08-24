extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var level_num = 0
var spawn_point
var check_point = 0
var shadow_timer = 0
var ghost_timer = 0
var midnight = false
var GLOBAL_BAR_POS
var en = preload("res://data/enemy/ghost.tscn")
var vol 
var s_pos
var loop1 = load("res://data/audio/bgm/s_loop_1.ogg")
var loop2 = load("res://data/audio/bgm/s_loop_2.ogg")
var loop3 = load("res://data/audio/bgm/s_loop_3.ogg")
var loop4 = load("res://data/audio/bgm/s_loop_4.ogg")
var loop5 = load("res://data/audio/bgm/s_loop_5.ogg")
var loop6 = load("res://data/audio/bgm/s_loop_6.ogg")
var fake_door =false
var good_door1 = false
var good_door2 = false
var good_door3 = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	spawn_point = get_node("player").get_pos()
	System.set_spawn_point(spawn_point)
	GLOBAL_BAR_POS = get_node("player/ui/shadow_bar/bar").get_pos()
	get_node("StreamPlayer").set_volume(0.0)
	set_process(true)
	for i in get_node("darkness").get_children():
		i.connect("body_enter", self,"_lose_light")
	pass
	for i in get_node("pit").get_children():
		i.connect("body_enter", self,"_respawn")
	pass
	for i in get_node("spring").get_children():
		i.connect("body_enter", self,"_spring")
	pass
	for i in get_node("doors").get_children():
		i.connect("body_enter", self,"_fake_door_enter")
		i.connect("body_exit", self,"_fake_door_exit")
	pass
	for i in get_node("Checkpoints").get_children():
		i.connect("body_enter", self,"_checkpoint_enter")
		i.connect("body_enter_shape", self,"_checkpoint_clear")
		print("yes")
	pass
	
func _process(delta):
	get_node("player/Camera2D").align()
	if (fake_door==true and get_node("player").up_pushed ==true):
		get_node("player").set_pos(get_node("drop_loc").get_pos())
	if (good_door1==true and get_node("player").up_pushed ==true):
		get_node("player").set_pos(get_node("drop_loc1").get_pos())
	if (good_door2==true and get_node("player").up_pushed ==true):
		get_node("player").set_pos(get_node("drop_loc2").get_pos())
	if (good_door3==true and get_node("player").up_pushed ==true):
		get_node("player").set_pos(get_node("drop_loc3").get_pos())
	
	
	if shadow_timer > 0.5 :
		shadow_timer = 0
		var opc = get_node("player/shadow_overlay").get_opacity() + 0.01
		vol = get_node("StreamPlayer").get_volume()
		if (vol < 0.88):
			vol+=0.009
			if (vol < 0.16 && vol > 0.0 && get_node("StreamPlayer").get_stream() != loop1):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop1)
				get_node("StreamPlayer").seek_pos(s_pos)
				get_node("StreamPlayer").play()
			if (vol < 0.32 && vol > 0.16 && get_node("StreamPlayer").get_stream() != loop2):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop2)
				get_node("StreamPlayer").seek_pos(s_pos)
				get_node("StreamPlayer").play()
			if (vol < 0.48 && vol > 0.32 && get_node("StreamPlayer").get_stream() != loop3):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop3)
				get_node("StreamPlayer").seek_pos(s_pos)
				get_node("StreamPlayer").play()
			if (vol < 0.60 && vol > 0.48 && get_node("StreamPlayer").get_stream() != loop4):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop4)
				get_node("StreamPlayer").seek_pos(s_pos)
				get_node("StreamPlayer").play()
			if (vol < 0.72 && vol > 0.60 && get_node("StreamPlayer").get_stream() != loop5):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop5)
				get_node("StreamPlayer").play()
			if (vol < 0.88 && vol > 0.72 && get_node("StreamPlayer").get_stream() != loop6):
				s_pos = get_node("StreamPlayer").get_pos()
				get_node("StreamPlayer").set_stream(loop6)
				get_node("StreamPlayer").seek_pos(s_pos)
				get_node("StreamPlayer").play()
			get_node("StreamPlayer").set_volume(vol)
		var light_length = get_node("player/ui/shadow_bar/bar").get_scale().x - 0.00328
		if (light_length < 0):
				light_length = 0
		if opc < 0.95:
			get_node("player/ui/shadow_bar/bar").set_scale(Vector2(light_length, 0.21))
			get_node("player/shadow_overlay").set_opacity(opc)
			midnight = false
		else:
			midnight = true
	else:
		shadow_timer += delta
	
	
	if ghost_timer > 4 and get_node("player/shadow_overlay").get_opacity() > 0.5:
		if midnight == true:
			ghost_timer = 0
			var ghost = en.instance()
			ghost.connect("body_enter", self,"_end_game")
			get_node("Enemies").add_child(ghost)
			ghost.attack(get_node("player").get_pos())
		if midnight == false:
			ghost_timer = 0
			var ghost = en.instance()
			get_node("Enemies").add_child(ghost)
			ghost.scare (get_node("player").get_pos())
	else:
		ghost_timer += delta

func _end_game(body):
	if (get_node("player").get_instance_ID() == body.get_instance_ID() and Physics.get_attack() == true):
		get_node("player").set_process(false)
		get_node("player").set_process_input(false)
		set_process(false)
		get_node("player/shadow_overlay").set_opacity(1.0)
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().reload_current_scene()
	pass

func _fake_door_exit(body): 
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		fake_door = false

func _fake_door_enter(body):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		fake_door = true

func _spring(body):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		Sound.play("spring")
		get_node("player").spring = true
		get_node("player").jumps = 0
		get_node("player").speed_y = -1200

func _respawn(body):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		get_node("player").set_pos(System.spawn_point)
		if (get_node("player").i_timer <= 0.1):
			Sound.play("hit")
			get_node("player").JUMP_FORCE = 200
			get_node("player").jumps = 0
			get_node("player").invincible = true
			get_node("player").i_timer = 6

func _lose_light(body):
	if (get_node("player").i_timer <= 0.1):
		if (get_node("player").get_instance_ID() == body.get_instance_ID()):
			Sound.play("hit")
			get_node("player").JUMP_FORCE = 200
			get_node("player").jumps = 0
			get_node("player").invincible = true
			get_node("player").i_timer = 6
			var o = get_node("player/shadow_overlay").get_opacity() + 0.02
			if o < 0.95:
				var light_length = get_node("player/ui/shadow_bar/bar").get_scale().x - 0.00456
				if (light_length < 0):
					light_length = 0
				get_node("player/ui/shadow_bar/bar").set_scale(Vector2(light_length, 0.21))
				get_node("player/shadow_overlay").set_opacity(o)
			vol = get_node("StreamPlayer").get_volume()
			if (vol < 0.88):
				vol+=0.018
				if (vol < 0.16 && vol > 0.0 && get_node("StreamPlayer").get_stream() != loop1):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop1)
					get_node("StreamPlayer").seek_pos(s_pos)
					get_node("StreamPlayer").play()
				if (vol < 0.32 && vol > 0.16 && get_node("StreamPlayer").get_stream() != loop2):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop2)
					get_node("StreamPlayer").seek_pos(s_pos)
					get_node("StreamPlayer").play()
				if (vol < 0.48 && vol > 0.32 && get_node("StreamPlayer").get_stream() != loop3):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop3)
					get_node("StreamPlayer").seek_pos(s_pos)
					get_node("StreamPlayer").play()
				if (vol < 0.60 && vol > 0.48 && get_node("StreamPlayer").get_stream() != loop4):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop4)
					get_node("StreamPlayer").seek_pos(s_pos)
					get_node("StreamPlayer").play()
				if (vol < 0.72 && vol > 0.60 && get_node("StreamPlayer").get_stream() != loop5):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop5)
					get_node("StreamPlayer").play()
				if (vol < 0.88 && vol > 0.72 && get_node("StreamPlayer").get_stream() != loop6):
					s_pos = get_node("StreamPlayer").get_pos()
					get_node("StreamPlayer").set_stream(loop6)
					get_node("StreamPlayer").seek_pos(s_pos)
					get_node("StreamPlayer").play()
				get_node("StreamPlayer").set_volume(vol)


func _checkpoint_enter(body):
	print("enter")
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		System.set_spawn_point(get_node("player").get_pos())
		var f = preload("res://data/animations/flash.tscn")
		var flash = f.instance()
		get_node("player").add_child(flash)
		if (get_node("Enemies").get_child_count() > 0):
			for i in get_node("Enemies").get_children():
				i.queue_free()
		for i in get_node("Checkpoints").get_children():
			if (i.check_area(body)):
				if (System.difficulty == 2):
					if (get_node("StreamPlayer").get_volume() > .48):
						get_node("StreamPlayer").set_volume(0.48)
					if (get_node("player/shadow_overlay").get_opacity() > .45):
						get_node("player/shadow_overlay").set_opacity(0.45)
					if (get_node("player/ui/shadow_bar/bar").get_scale().x < 0.13):
						get_node("player/ui/shadow_bar/bar").set_scale(Vector2(0.13,0.21))
				if (System.difficulty < 2):
					get_node("StreamPlayer").set_volume(0)
					get_node("player/shadow_overlay").set_opacity(0.1)
					get_node("player/ui/shadow_bar/bar").set_scale(Vector2(0.26,0.21))
				if (System.difficulty > 0):
					i.queue_free()
		


	



func _on_door12_body_enter( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door1 = true


func _on_door13_body_enter( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door2 = true


func _on_door14_body_enter( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door3 = true


func _on_door12_body_exit( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door1 = false


func _on_door13_body_exit( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door2 = false


func _on_door14_body_exit( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		good_door3 = false


func _on_exit_body_enter( body ):
	if (get_node("player").get_instance_ID() == body.get_instance_ID()):
		if (level_num == 1):
			get_tree().change_scene("res://data/scenes/scene_2/scene_2.tscn")
		if (level_num == 2):
			get_tree().change_scene("res://data/scenes/scene_3/scene_3.tscn")
		if (level_num == 3):
			get_tree().change_scene("res://data/scenes/scene_4/scene_4.tscn")
		
		
		
		
		

