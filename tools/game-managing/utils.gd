extends RefCounted
class_name Utils


static func free_children(node: Node) -> void:
	for i in node.get_children():
		i.queue_free()
