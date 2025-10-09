extends RayCast3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var hitObj = get_collider()
		print("Colide with door")
		if hitObj.has_method("interact") && Input.is_action_just_pressed("interact"):
			hitObj.interact()
			
