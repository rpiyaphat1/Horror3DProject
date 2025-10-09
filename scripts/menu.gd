extends CanvasLayer

signal resume_requested
signal quit_requested
signal menu_requested

@export var menu_scene_path: String = "res://scenes/opening_scene.tscn" # ปรับตามโปรเจกต์

@onready var resume_btn = $ResumeButton
@onready var quit_btn  = $QuitButton
@onready var menu_btn  = $Menu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	visible = false
	resume_btn.pressed.connect(_emit_resume)
	quit_btn.pressed.connect(_emit_quit)
	menu_btn.pressed.connect(_go_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_emit_resume()
		get_viewport().set_input_as_handled()

func _emit_resume() -> void:
	emit_signal("resume_requested")

func _emit_quit() -> void:
	get_tree().quit()

func _go_menu() -> void:
	emit_signal("menu_requested")
	get_tree().paused = false        # สำคัญ: ต้อง unpause ก่อนเปลี่ยนซีน
	visible = false
	get_tree().change_scene_to_file(menu_scene_path)
