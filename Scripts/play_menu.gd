extends Control

const scene_type : String = "Play menu"
var pressed_level : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up(extra_arg_0: int) -> void:
	print(extra_arg_0)
	pressed_level = extra_arg_0
