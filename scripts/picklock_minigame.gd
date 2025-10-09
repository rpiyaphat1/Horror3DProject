extends Control

# ===== Config =====
@export var rotation_speed: float = 360.0      # องศาต่อวินาที
@export var success_zone_size: float = 45.0    # ขนาดโซน (องศา)

# ออฟเซ็ตของ asset:
# - ถ้าเข็มวาดให้ "ชี้ขึ้น" ตั้งเป็น 90 (เพราะ 0° ของ Godot ชี้ขวา)
# - ถ้าพายมี "ขอบเริ่มต้น" อยู่ด้านบน ตั้งเป็น 90 (ถ้าขอบชี้ขวา ตั้ง 0)
@export var needle_zero_deg: float = 90.0
@export var zone_start_edge_deg: float = 90.0

signal minigame_finished(was_successful: bool)

var is_active: bool = false
var needle_angle: float = 0.0                  # มุมสำหรับหมุน node เข็ม (ตามที่เห็น)
var success_start_angle: float = 0.0           # มุมที่ใช้หมุน node พาย (เพื่อแสดงผล)
var success_end_angle: float = 0.0

@onready var needle: TextureRect = $Needle
@onready var success_zone: TextureRect = $SuccessZone
@onready var result_label: Label = $ResultLabel

func _ready() -> void:
	start_minigame()

func _process(delta: float) -> void:
	if not is_active:
		return
	needle_angle = fposmod(needle_angle + rotation_speed * delta, 360.0)
	needle.rotation_degrees = needle_angle

func _input(event: InputEvent) -> void:
	if is_active and event.is_action_pressed("ui_accept"):
		set_process_input(false)
		check_success()

func start_minigame() -> void:
	show()
	result_label.text = ""
	is_active = true
	set_process_input(true)

	needle_angle = 0.0
	needle.rotation_degrees = needle_angle

	# สุ่มให้โซนไม่คร่อม 0° เพื่อง่ายต่อการวางภาพ
	success_start_angle = randf_range(0.0, 360.0 - success_zone_size)
	success_end_angle = success_start_angle + success_zone_size
	success_zone.rotation_degrees = success_start_angle

func _norm_deg(d: float) -> float:
	return fposmod(d, 360.0)  # 0..360

func _span_contains(angle: float, start: float, end: float) -> bool:
	# เช็คแบบ wrap-safe: ระยะจาก start ไป angle ต้องไม่เกินช่วง start→end
	var diff := _norm_deg(angle - start)
	var span := _norm_deg(end - start)
	return diff <= span

func check_success() -> void:
	is_active = false

	# 1) แปลง "มุมที่เห็น" -> "มุมจริง" ตามระบบแกนของ Godot ด้วยออฟเซ็ตของ asset
	var needle_deg := _norm_deg(needle_angle - needle_zero_deg)

	# 2) แปลง "มุมเริ่มของรูปพาย" -> "ขอบเริ่มจริง" ด้วยออฟเซ็ตของรูปพาย
	var zone_start := _norm_deg(success_start_angle - zone_start_edge_deg)
	var zone_end   := _norm_deg(zone_start + success_zone_size)

	var in_zone := _span_contains(needle_deg, zone_start, zone_end)

	if in_zone:
		result_label.text = "SUCCESS!"
		result_label.modulate = Color(0.2, 0.8, 0.2)
		minigame_finished.emit(true)
	else:
		result_label.text = "FAILED!"
		result_label.modulate = Color(0.9, 0.2, 0.2)
		minigame_finished.emit(false)

	await get_tree().create_timer(1.0).timeout
	hide()
