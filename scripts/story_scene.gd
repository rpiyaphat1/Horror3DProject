extends CanvasLayer

@export_file("*.tscn") var next_scene_path : String = "res://scenes/Home.tscn"

func _ready() -> void:
	$SkipButton.pressed.connect(_on_start_pressed)
	$SkipButton.grab_focus()

func _on_start_pressed() -> void:
	if next_scene_path.is_empty():
		push_error("No scene assigned to 'next_scene_path'")
		return
	get_tree().change_scene_to_file(next_scene_path)
