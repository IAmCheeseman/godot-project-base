extends Node2D
class_name AstarPathfinding

var astar := AStar2D.new()


const _DIRECTIONS = [
	Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN,
]

## Generates astar connections from a tileset
func generate_astar(tileset: TileMap) -> void:
	astar.clear()
	
	var size = tileset.get_used_rect().end
	
	for x in size.x:
		for y in size.y:
			var xy = Vector2(x, y)
			var tile_empty = true
			for i in tileset.get_layers_count():
				if tileset.get_cell_source_id(i, xy, false) != -1:
					tile_empty = false
			if !tile_empty: continue
			var idx = _get_astar_cell_id(xy, tileset)
			astar.add_point(
				idx,
				tileset.map_to_local(Vector2(x, y))
			)
	
	for x in size.x:
		for y in size.y:
			var xy = Vector2(x, y)
			var tile_empty = true
			for i in tileset.get_layers_count():
				if tileset.get_cell_source_id(i, xy, false) != -1:
					tile_empty = false
			if !tile_empty: continue
			
			var idx = _get_astar_cell_id(xy, tileset)
			for dir in _DIRECTIONS:
				var neighbor_cell = xy + dir
				var idx_neighbor = _get_astar_cell_id(neighbor_cell, tileset)
				if astar.has_point(idx_neighbor):
					astar.connect_points(idx, idx_neighbor, false)

func _get_astar_cell_id(cell: Vector2, tileset: TileMap) -> int:
	return int(cell.y + cell.x * tileset.get_used_rect().size.y)

## Returns the direction you need to go in from [code]start_pos[/code] to
## get to [code]target_pos[/code]
func get_astar_path(start_pos: Vector2, target_pos: Vector2) -> Vector2:
	var idx_start = astar.get_closest_point(start_pos)
	var idx_target = astar.get_closest_point(target_pos)
	
	if astar.has_point(idx_start) and astar.has_point(idx_target):
		var path := Array(astar.get_point_path(idx_start, idx_target))
		if path.size() <= 1: return Vector2.ZERO
		return start_pos.direction_to(path[1])
	return Vector2.ZERO

## Returns an array of positions you need to pass through to get to
## [code]target_pos[/code]
func get_astar_path_arr(start_pos: Vector2, target_pos: Vector2) -> Array:
	var idx_start = astar.get_closest_point(start_pos)
	var idx_target = astar.get_closest_point(target_pos)
	
	if astar.has_point(idx_start) and astar.has_point(idx_target):
		return Array(astar.get_point_path(idx_start, idx_target))
	return []
