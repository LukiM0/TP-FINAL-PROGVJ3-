extends Control

var level = "res://world.tscn"

func _ready():
	
	$AnimationPlayer.play("start_up")

func _on_btn_play_click_end():
	pass

func _on_btn_exit_click_end():
	pass


func _on_animation_player_animation_finished(start_up):
	$Encendido.queue_free()
	$AnimationPlayer.play("main_menu")


func _on_btn_play_pressed():
	var _level = get_tree().change_scene_to_file("res://Utility/turorial.tscn")


func _on_btn_exit_pressed():
	get_tree().quit()
