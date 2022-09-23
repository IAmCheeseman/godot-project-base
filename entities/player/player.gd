extends Entity


func _default_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	input_dir = input_dir.normalized()
	
	var accel_delta = accel if velocity.dot(input_dir) > 0 else frict
	velocity = velocity.move_toward(input_dir * speed, accel_delta * delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		Utils.create_new_dialog("You pressed space! [shake] `[img]ui/assets/happy.png[/img] Now die.[/shake]")
	
	move_and_slide()
