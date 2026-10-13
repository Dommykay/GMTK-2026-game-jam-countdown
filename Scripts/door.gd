extends Node2D

func open() -> void:
	$Door.collision_enabled = false
	modulate.a = 0.0
