extends CanvasLayer

@export_file("*.tscn") var next_scene_path : String = "res://scenes/game.tscn"

func _ready() -> void:
	$StartButton.pressed.connect(_on_start_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)
	$StartButton.grab_focus()

func _on_start_pressed() -> void:
	if next_scene_path.is_empty():
		push_error("No scene assigned to 'next_scene_path'")
		return
	get_tree().change_scene_to_file(next_scene_path)

func _on_quit_pressed() -> void:
	get_tree().quit()
