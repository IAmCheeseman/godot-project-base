extends TileMap
class_name ShadowedTileMap
## A tilemap that clones itself at runtime
## and then moves the clone down to look
## like a shadow

@export_node_path(Node2D) var enemies_path
@onready var enemies = get_node(enemies_path)


func _ready() -> void:
	var shadow: TileMap = duplicate(Node.DUPLICATE_USE_INSTANCING)
	shadow.tile_set = shadow.tile_set.duplicate(true)
	shadow.tile_set.remove_physics_layer(0)
	
	shadow.show_behind_parent = true
	shadow.position.y = 8
	shadow.set_layer_modulate(0, Color(0, 0, 0, 0.5))
	shadow.z_index = -2
	
	for i in range(1, shadow.get_layers_count()):
		shadow.remove_layer(i)
	
	add_child(shadow)
	
	for i in shadow.get_children():
		i.queue_free()
	
	await FrameTimer.physics_timer(self).timeout
	enemies.get_parent().call_deferred("remove_child", enemies)
	await FrameTimer.physics_timer(self).timeout
	add_child(enemies)

