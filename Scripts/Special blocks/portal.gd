extends Node2D

const block_type : String = "Portal"
var placed : bool = false
@onready var blue : Node2D = $Texture/Blue
@onready var orange : Node2D = $Texture/Orange
@onready var cooldown : Timer = $"Texture/Teleport CD"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not placed:
		modulate.a = (1.7+sin(Time.get_ticks_usec()/500000.0))/4
	else:
		pass

func place_and_activate() -> void:
	placed = true
	modulate.a = 1.0
	$"Texture/Blue/Portal area".monitoring = true
	$"Texture/Orange/Portal area".monitoring = true



func _on_player_enter_orange(body: Node2D) -> void:
	if cooldown.is_stopped():
		body.get_parent().get_parent().delete_and_spawn_player_at_coords_with_transforms(blue.global_position)
		cooldown.start()
		$Texture/Vwoop.play()


func _on_player_enter_blue(body: Node2D) -> void:
	if cooldown.is_stopped():
		body.get_parent().get_parent().delete_and_spawn_player_at_coords_with_transforms(orange.global_position)
		cooldown.start()
		$Texture/Vwoop.play()
