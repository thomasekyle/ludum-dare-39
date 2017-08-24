extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var scene_num = 0
export var scene_auto = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("AnimatedSprite").set_frame(0)
	if (scene_num == 1):
		get_node("AnimatedSprite").set_animation("part1")
	if (scene_num == 4):
		get_node("AnimatedSprite").set_animation("part1")
	set_process(true)
	
	
func _process(delta):
	if (scene_num == 1):
		if (get_node("AnimatedSprite").get_animation() == "part1" and get_node("AnimatedSprite").get_frame() == 14):
			var t = Timer.new()
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("AnimatedSprite").set_animation("part2")
			get_node("AnimatedSprite").set_frame(0)
			
		if (get_node("AnimatedSprite").get_animation() == "part2" and get_node("AnimatedSprite").get_frame() == 13):
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("AnimatedSprite").set_animation("part3")
			get_node("AnimatedSprite").set_frame(0)
			
		if (get_node("AnimatedSprite").get_animation() == "part3" and get_node("AnimatedSprite").get_frame() == 15):
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_tree().change_scene("res://data/level/first_level/first_level.tscn")
	
	if (scene_num == 2):
		if (get_node("AnimatedSprite").get_frame() == 22):
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_tree().change_scene("res://data/level/second_level/second_level.tscn")
			
	if (scene_num == 3):
		if (get_node("AnimatedSprite").get_frame() == 27):
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_tree().change_scene("res://data/level/third_level/third_level.tscn")
			
	if (scene_num == 4):
		if (get_node("AnimatedSprite").get_animation() == "part1" and get_node("AnimatedSprite").get_frame() == 12):
			get_node("AnimatedSprite").set_animation("part2")
			get_node("AnimatedSprite").set_frame(0)
			
		if (get_node("AnimatedSprite").get_animation() == "part2" and get_node("AnimatedSprite").get_frame() == 17):
			get_node("AnimatedSprite").set_animation("part3")
			get_node("AnimatedSprite").set_frame(0)
			
		if (get_node("AnimatedSprite").get_animation() == "part3" and get_node("AnimatedSprite").get_frame() == 1):
			var t = Timer.new()
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("AnimatedSprite").set_animation("part4")
			get_node("AnimatedSprite").set_frame(0)
			
		
		if (get_node("AnimatedSprite").get_animation() == "part4" and get_node("AnimatedSprite").get_frame() == 20):
			get_node("AnimatedSprite").set_animation("part5")
			get_node("AnimatedSprite").set_frame(0)
			
		if (get_node("AnimatedSprite").get_animation() == "part5" and get_node("AnimatedSprite").get_frame() == 6):
			var t = Timer.new()
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_node("AnimatedSprite").set_animation("part6")
			get_node("AnimatedSprite").set_frame(0)
			
			
		if (get_node("AnimatedSprite").get_animation() == "part6" and get_node("AnimatedSprite").get_frame() == 16):
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			get_tree().change_scene("res://data/scenes/title_screen.tscn")
	
