extends Camera2D
class_name CustomCamera

@export_category("Camera Look")
## How much the mouse position affects the camera offset.
@export var weight := 0.125

var _priority := 0
var _shake_dir := Vector2.ZERO
var _shake_range := [0., 0.]
var _shake_time := 0.
var _shake_freq := 0.
var _shake_reduce := false

var _jump_timer: Timer
var _shake_timer: Timer

@onready var _parent: Node2D = get_parent()


func _ready() -> void:
	GameManager.camera = self
	
	_jump_timer = _set_up_timer()
	_jump_timer.connect("timeout", Callable(self, "jump"))
	_shake_timer = _set_up_timer()
	_shake_timer.connect("timeout", Callable(self, "reset"))
	
	reset()


func _process(delta: float) -> void:
	var mouse_pos = _parent.get_local_mouse_position()
	position = round(mouse_pos * weight)
	
	offset = offset.move_toward(Vector2.ZERO, 100 * delta)


func _set_up_timer() -> Timer:
	var new_timer = Timer.new()
	add_child(new_timer)
	
	return new_timer


## Resets the shake to be still.
func reset() -> void:
	_priority = 0
	_shake_dir = Vector2.ZERO
	_shake_range = [0., 0.]
	_shake_time = 0
	_shake_freq = 0
	_shake_reduce = false


## Shakes the camera if [code]pri[/code] is greater than the current shake's priority.
## Shakes between [code]shake_min[/code] and [code]shake_max[/code] every [code]freq[/code]
## seconds, for [code]time[/code] seconds. Amount of shake goes down over time if
## [code]reduce[/code] is enabled. Always shakes in [code]set_dir[/code] if set.
func shake(pri: int, shake_min: float, shake_max: float, time: float, freq: float, reduce: bool, set_dir:=Vector2.ZERO) -> void:
	if pri <= _priority: return
	_priority = pri
	_shake_range = [ shake_min * Settings.screenshake, shake_max * Settings.screenshake ]
	_shake_time = clamp(time, 0.01, INF)
	_shake_freq = freq
	_shake_reduce = reduce
	_shake_dir = set_dir

	_shake_timer.start(_shake_time)
	_jump_timer.start(_shake_freq)

	_jump()


func _jump() -> void:
	var dist = randf_range(_shake_range[0], _shake_range[1])
	if _shake_reduce: dist *= _shake_timer.time_left / _shake_timer.wait_time
	var dir = Vector2.RIGHT.rotated(randf_range(0, PI * 2)) if _shake_dir == Vector2.ZERO else _shake_dir

	offset = dir * dist
