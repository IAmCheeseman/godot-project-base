extends Area2D
class_name LoadingZone

@export_file("*.tscn") var go_to := "res://world/levels/level_1a.tscn"


func _ready() -> void:
	connect(
		"body_entered",
		Callable(self, "_on_body_entered")
	)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		get_tree().change_scene(go_to)
