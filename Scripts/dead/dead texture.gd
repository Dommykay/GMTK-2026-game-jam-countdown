extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = lerp(scale, Vector2(0,0), 0.1)
	modulate.a = lerp(modulate.a, 0.0, 0.1)
