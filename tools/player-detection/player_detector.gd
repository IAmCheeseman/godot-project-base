extends Area2D

@onready var rc := $RayCast

func get_player() -> CharacterBody2D:
	for b in get_overlapping_bodies():
		if b.is_in_group("player"):
			rc.target_position = to_local(b.global_position)
			rc.force_raycast_update()
			if rc.is_colliding():
				continue
			return b
	return null
