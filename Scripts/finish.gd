extends Node2D

var finished : bool = false

func _on_finish(body: Node2D) -> void:
	finished = true
	$"Win sound".play()
