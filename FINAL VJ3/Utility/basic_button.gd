extends Button

signal click_end()



func _on_mouse_entered():
	$snd_hover.play()


func _on_pressed():
	$snd_click.play()
	#get_tree().change_scene_to_file("res://world.tscn")


func _on_snd_click_finished():
	emit_signal("click_end")
