extends RefCounted
class_name Utils


static func free_children(node: Node) -> void:
	for i in node.get_children():
		i.queue_free()


static func create_new_dialog(text: String, speed:=0.05) -> CanvasLayer:
	var new_dialog = preload("res://tools/dialog/dialog.tscn").instantiate()
	new_dialog.target_text = text
	new_dialog.speed = speed
	GameManager.add_child(new_dialog)
	
	if is_instance_valid(GameManager.current_dialog):
		GameManager.current_dialog.queue_free()
	GameManager.current_dialog = new_dialog
	
	return new_dialog
