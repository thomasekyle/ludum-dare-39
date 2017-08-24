extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_credits_pressed():
	get_node("start").hide()
	get_node("credits").show()


func _on_back1_pressed():
	get_node("credits").hide()
	get_node("start").show()


func _on_back_pressed():
	get_node("difficulty").hide()
	get_node("start").show()


func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_node("start").hide()
	get_node("difficulty").show()


func _on_easy_pressed():
	System.difficulty = 0
	get_tree().change_scene("res://data/scenes/scene_1/scene_1.tscn")
	pass # replace with function body


func _on_normal_pressed():
	System.difficulty = 1
	get_tree().change_scene("res://data/scenes/scene_1/scene_1.tscn")
	pass # replace with function body


func _on_nightmare_pressed():
	System.difficulty = 2
	get_tree().change_scene("res://data/scenes/scene_1/scene_1.tscn")
	pass # replace with function body


func _on_easy_mouse_enter():
	get_node("difficulty/dif").set_text("Challenging, but not impossible.")


func _on_normal_mouse_enter():
	get_node("difficulty/dif").set_text("Very challenging. The way the game was meant to be played.")


func _on_nightmare_mouse_enter():
	get_node("difficulty/dif").set_text("For those who are good at platformers. Punishes small mistakes.")


func _on_easy_mouse_exit():
	get_node("difficulty/dif").set_text("")


func _on_normal_mouse_exit():
	get_node("difficulty/dif").set_text("")


func _on_nightmare_mouse_exit():
	get_node("difficulty/dif").set_text("")
