extends Entity


func _default_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	input_dir = input_dir.normalized()
	
	var accel_delta = accel if velocity.dot(input_dir) > 0 else frict
	velocity = velocity.move_toward(input_dir * speed, accel_delta * delta)
	
	move_and_slide()
