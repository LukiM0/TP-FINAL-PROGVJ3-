extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since th e previous frame.
func _process(delta):
	pass


func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
