extends Control

@onready var anim := $AnimationPlayer

@export_file("*.tscn") var load := "res://world/world.tscn"


func load_game() -> void:
	get_tree().change_scene_to_file(load)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if !event.pressed: return
		if anim.current_animation_position < 2:
			anim.seek(2)
		else:
			load_game()
