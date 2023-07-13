extends RefCounted
class_name State

enum CallbackType {
	START,
	PROC,
	END,
}

## Name of state.
var name: String

## The callbacks
var callbacks = {} 

func _init(n: String) -> void:
	name = n

func callback(type: CallbackType, function: Callable) -> State:
	callbacks[type] = function
	return self;
