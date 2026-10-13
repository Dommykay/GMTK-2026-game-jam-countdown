class_name GameController extends Node

@export var world_2d : Node2D
@export var gui : Control

const menuScene : PackedScene = preload("res://Scenes/Main menu.tscn")
const mainScene : PackedScene = preload("res://Scenes/2d main.tscn")
const playMenuScene : PackedScene = preload("res://Scenes/play menu.tscn")
const inGameInterfaceScene : PackedScene = preload("res://Scenes/in_game_interface.tscn")


var current_2d_scene
var current_gui_scene

func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = menuScene.instantiate()
	add_child(current_gui_scene)

func _process(delta: float) -> void:
	if current_gui_scene:
		if current_gui_scene.scene_type == "Main menu":
			if $AudioStreamPlayer.playing == current_gui_scene.mute_music:
				$AudioStreamPlayer.playing = not current_gui_scene.mute_music
			if current_gui_scene.go_to_tutorial:
				current_gui_scene.queue_free()
				current_2d_scene = mainScene.instantiate()
				add_child(current_2d_scene)
				current_2d_scene.level_num = 0
				current_2d_scene.prepare_level()
				current_gui_scene = inGameInterfaceScene.instantiate()
				$Interface.add_child(current_gui_scene)
				
			elif current_gui_scene.go_to_main:
				current_gui_scene.queue_free()
				current_gui_scene = playMenuScene.instantiate()
				add_child(current_gui_scene)
		
		if current_gui_scene.scene_type == "Play menu":
			if current_gui_scene.pressed_level:
				current_2d_scene = mainScene.instantiate()
				add_child(current_2d_scene)
				current_2d_scene.level_num = current_gui_scene.pressed_level
				current_2d_scene.prepare_level()
				current_gui_scene.queue_free()
				current_gui_scene = inGameInterfaceScene.instantiate()
				$Interface.add_child(current_gui_scene)
	

	if Input.is_action_just_pressed("Go to menu"):
		if current_gui_scene:
			current_gui_scene.queue_free()
		if current_2d_scene:
			current_2d_scene.queue_free()
		current_gui_scene = menuScene.instantiate()
		add_child(current_gui_scene)
		
		
	if current_2d_scene and current_gui_scene.scene_type == "In-game interface":
		if current_2d_scene.finish:
			if current_2d_scene.finish.finished:
				current_gui_scene.finished = true
		
