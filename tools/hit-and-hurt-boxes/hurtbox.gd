extends Area2D

@export var iframes := 0.01

signal took_damage(amt: float, kb: Vector2)

func take_damage(amt: float, kb: Vector2) -> void:
	emit_signal("took_damage", amt, kb)
