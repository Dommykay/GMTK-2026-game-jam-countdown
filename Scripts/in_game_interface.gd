extends Control

const scene_type = "In-game interface"
var finished = false

var last_speed : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_speed = Engine.time_scale
	$"You won".modulate.a = 0.0
	$"Game speed container/Speed bar".value = Engine.time_scale
	$"Game speed container".modulate.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last_speed != Engine.time_scale:
		last_speed = Engine.time_scale
		$"Game speed container/Speed bar".value = Engine.time_scale
		$"Hide game speed".start()
	if not $"Hide game speed".is_stopped():
		$"Game speed container".modulate.a = lerp($"Game speed container".modulate.a, 1.0, 5*delta)
	else:
		$"Game speed container".modulate.a = lerp($"Game speed container".modulate.a, 0.0, 5*delta)
		
	if finished:
		$"You won".modulate.a = 1.0
