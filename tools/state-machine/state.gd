extends RefCounted
class_name State

## Name of state.
var name: String
## Gets called every frame this state is active.
var process_func: Callable
## Gets called when this state starts being active.
var ready_func: Callable
## Gets called when this state stops being active.
var end_func: Callable


func _init(n: String, pf: Callable, rf=null, ef=null) -> void:
	name = n
	process_func = pf
	ready_func = rf
	end_func = ef
