extends Node2D

var picked_up : bool = false

func _on_pickup_box_body_entered(body: Node2D) -> void:
	picked_up = true
	modulate.a = 0.0
