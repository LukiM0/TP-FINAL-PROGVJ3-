extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("win")
	pass # Replace with function body.


func _on_btn_menu_pressed():
	get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
