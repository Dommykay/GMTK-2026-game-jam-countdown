extends Node2D

const scene_type : String = "Level"
const level_number : int = 2
@onready var door : Node2D = $Door
@onready var key : Node2D = $Key
@onready var finish : Node2D = $Finish
var door_opened : bool = false

const line_of_three_scene : PackedScene = preload("res://Scenes/Placeables/line of three.tscn")
const trampoline_scene : PackedScene = preload("res://Scenes/Placeables/trampoline.tscn")
const line_of_five_scene : PackedScene = preload("res://Scenes/Placeables/line of five.tscn")

var placeable_blocks : Array[Node2D] = [line_of_three_scene.instantiate(),
line_of_three_scene.instantiate(),
line_of_three_scene.instantiate(),
line_of_three_scene.instantiate(),
line_of_three_scene.instantiate(),
line_of_three_scene.instantiate(),
trampoline_scene.instantiate(),
trampoline_scene.instantiate(),
trampoline_scene.instantiate()]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Bat-o-matic 3000".place_and_activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not door_opened:
		if key.picked_up:
			door.open()
			key.queue_free()
			door.queue_free()
			door_opened = true
			$"Key jingle".play()
