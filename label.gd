extends Label
@export var msg := "โรงเรียนร้างกลางเงามืดถูกกล่าวขานว่าเป็นสถานที่ต้องสาป วิญญาณดวงใหญ่ที่ถูกผนึกด้วยยันต์โบราณยังคงกักเก็บความแค้น\nหากยันต์เหล่านี้ขาดหาย มันจะหลุดออกมาอาละวาด ผู้เล่นจึงต้องเสี่ยงชีวิตเข้าไปตามหาและเก็บยันต์ให้ครบเพื่อปลดปล่อยคำสาป\nแต่เบื้องหลังเงามืดกลับมีปีศาจบิดเบี้ยวรอคอยอยู่ มันเฝ้าติดตาม ไล่ล่า และสาบานว่าจะไม่ปล่อยให้ผู้ใดออกไปจากที่แห่งนี้ได้ง่าย ๆ\n"
@export var speed := 0.125   # วินาที/ตัวอักษร
@export var pitch_jitter := 0.1
@onready var Click := $Click

func _ready():
	text = msg
	visible_characters = 0           # Label ก็รองรับ property นี้
	for i in range(1, get_total_character_count()+1):
		if i%5 == 0:
			Click.play()
			Click.pitch_scale = 1.0 + randf_range(-pitch_jitter, pitch_jitter)
		visible_characters = i
		await get_tree().create_timer(speed).timeout
	Click.stop()
		
