extends CharacterBody2D
class_name Entity

@onready var sprite := $Sprite
@onready var hurtbox := $Collisions/Hurtbox
@onready var damage_manager := $DamageManager

@export var speed := 90.0
@export var accel := 800.0
@export var frict := 900.0

var _s_default := State.new("default") \
	.callback(State.CallbackType.PROC, _default_process)
var _state_machine := StateMachine.new(_s_default)


func _physics_process(delta: float) -> void:
	_state_machine.process(delta)


func _default_process(delta: float) -> void:
	pass
