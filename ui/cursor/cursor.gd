extends CanvasLayer

@onready var sprite := $Sprite


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta: float) -> void:
	sprite.global_position = get_tree().root.get_mouse_position()
