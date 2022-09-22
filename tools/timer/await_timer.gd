extends Node
class_name FrameTimer

class _PhysicsTimer extends Node:
	var _time_left := 1
	
	signal timeout
	
	func _init(time: int) -> void:
		_time_left = time + 1
	
	func _physics_process(_delta: float) -> void:
		_time_left -= 1
		if _time_left <= 0:
			emit_signal("timeout")

static func physics_timer(node: Node, time:=1) -> _PhysicsTimer:
	var new_timer = _PhysicsTimer.new(time)
	node.add_child(new_timer)
	return new_timer
