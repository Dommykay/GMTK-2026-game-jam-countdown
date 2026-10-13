extends Node2D

const block_type : String = "Trampoline"
var placed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not placed:
		modulate.a = (1.7+sin(Time.get_ticks_usec()/500000.0))/4

func place_and_activate() -> void:
	placed = true
	modulate.a = 1.0
	$Texture/Hitbox.collision_layer = 1
	$Texture/Hitbox.collision_mask = 1
	$"Sound hitbox".monitoring = true

func _on_player_bounce(body: Node2D) -> void:
	$Boing.play()
