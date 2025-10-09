extends RichTextLabel

#var Text = "โรงเรียนร้างกลางเงามืดถูกกล่าวขานว่าเป็นสถานที่ต้องสาป วิญญาณดวงใหญ่ที่ถูกผนึกด้วยยันต์โบราณยังคงกักเก็บความแค้น\nหากยันต์เหล่านี้ขาดหาย มันจะหลุดออกมาอาละวาด ผู้เล่นจึงต้องเสี่ยงชีวิตเข้าไปตามหาและเก็บยันต์ให้ครบเพื่อปลดปล่อยคำสาป\nแต่เบื้องหลังเงามืดกลับมีปีศาจบิดเบี้ยวรอคอยอยู่ มันเฝ้าติดตาม ไล่ล่า และสาบานว่าจะไม่ปล่อยให้ผู้ใดออกไปจากที่แห่งนี้ได้ง่าย ๆ\n"

func _ready() -> void:
	pass
	
func scroll_text(input_text:String)->void:
	visible_characters = 0
	text = input_text
	
	for i in get_parsed_text():
		visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
