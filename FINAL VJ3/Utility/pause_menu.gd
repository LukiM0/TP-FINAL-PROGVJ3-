extends Control

@onready var main = $"../../"

func _ready():
	$MarginContainer.visible = false

func resume():
	get_tree().paused = false
	$MarginContainer.visible = false

func pause():
	get_tree().paused = true
	$MarginContainer.visible = true

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
		$MarginContainer.visible = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
		$MarginContainer.visible = false

func _on_resume_pressed():
	resume()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
