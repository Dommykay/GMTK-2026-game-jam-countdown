extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Queue free timer".start()
	$Blood.emitting = true

func _on_queue_free_timer_timeout() -> void:
	get_parent().get_parent().reset_level()
	queue_free()
