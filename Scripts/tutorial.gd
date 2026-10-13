extends Node2D

const scene_type : String = "Level"
const level_number : int = 0
@onready var door : Node2D = $Door
@onready var key : Node2D = $Key
@onready var finish : Node2D = $Finish
var door_opened : bool = false

const repeating_block_scene : PackedScene = preload("res://Scenes/Placeables/line of three.tscn")

var placeable_blocks : Array[Node2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Bat-o-matic 3000".place_and_activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placeable_blocks.size() < 2:
		var repeating_block : Node2D = repeating_block_scene.instantiate()
		placeable_blocks.append(repeating_block)
	if not door_opened:
		if key.picked_up:
			door.open()
			key.queue_free()
			door.queue_free()
			door_opened = true
			$"Key jingle".play()
