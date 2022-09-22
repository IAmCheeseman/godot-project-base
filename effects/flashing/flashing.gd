extends Node
class_name FlashingEffect

@export var time := 0.1
@export_node_path(Sprite2D) var sprite_path
@onready var sprite := get_node(sprite_path)

const FLASHING_SHADER := preload("res://effects/flashing/flashing.tres")

var flash_time: Timer

func _ready() -> void:
	flash_time = Timer.new()
	flash_time.wait_time = time
	flash_time.one_shot = true
	add_child(flash_time)
	
	flash_time.connect("timeout", Callable(self, "_on_flash_timer_timeout"))
	
	sprite.material = FLASHING_SHADER.duplicate()


func start() -> void:
	flash_time.start()
	sprite.material.set_shader_parameter("color", Color(1, 1, 1))
	sprite.material.set_shader_parameter("on", 1)


func _on_flash_timer_timeout() -> void:
	sprite.material.set_shader_parameter("on", 0)
