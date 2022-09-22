extends RefCounted
class_name StateMachine
## You can use this class as so:
## [codeblock]
## var _s_default = State.new(
##     "default",
##     func(delta: float):
##         print("hey")
## )
## var _state_machine = StateMachine.new(_s_default)
## [/codeblock]

## The active state.
var _current_state: State


func _init(default_state: State) -> void:
	_current_state = default_state


## Changes the current state to [code]to[/code].
func change_state(to: State) -> void:
	if is_instance_valid(_current_state):
		if _current_state.end_func:
			_current_state.end_func.call()
	
	_current_state = to
	
	if _current_state == null:
		return
	if _current_state.ready_func:
		_current_state.ready_func.call()

## Processes the current state.
func process(delta: float) -> void:
	if _current_state == null:
		return
	_current_state.process_func.call(delta)

## Returns [code]current_state[/code]'s name.
func get_state_name() -> String:
	if _current_state == null:
		return "null"
	return _current_state.name
