extends Control

const scene_type : String = "Main menu"
@export var go_to_tutorial : bool
@export var go_to_main : bool
@onready var mute_music : bool = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_up() -> void:
	go_to_main = true

func _on_tutorial_button_up() -> void:
	go_to_tutorial = true


func _on_mute_music_button_up() -> void:
	mute_music = not mute_music
	if mute_music:
		%"Mute music button/Label".text = '''Unmute
		BGM'''
	else:
		%"Mute music button/Label".text = '''Mute
		BGM'''
	
