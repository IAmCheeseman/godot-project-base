extends Area2D

@export var damage := 1.0
@export var set_kb_dir := Vector2.ZERO

signal hit(area: Area2D)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		var kb = global_position.direction_to(area.global_position)
		if set_kb_dir != Vector2.ZERO:
			kb = set_kb_dir
		area.take_damage(damage, kb)
		
		emit_signal("hit", area)
