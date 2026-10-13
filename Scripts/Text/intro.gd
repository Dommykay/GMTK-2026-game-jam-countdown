extends Node2D

var collidingRn = false

func _ready() -> void:
	modulate.a = 0.0

func _process(delta: float) -> void:
	if collidingRn:
		modulate.a = lerp(modulate.a, 1.0, 10*delta)
	else:
		modulate.a = lerp(modulate.a, 0.0, 10*delta)

func _on_visible_area_body_entered(body: Node2D) -> void:
	collidingRn = true

func _on_visible_area_body_exited(body: Node2D) -> void:
	collidingRn = false
