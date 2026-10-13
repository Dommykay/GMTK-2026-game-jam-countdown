extends Node2D

const playerScene : PackedScene = preload("res://Scenes/character.tscn")
const cameraScene : PackedScene = preload("res://Scenes/camera.tscn")
const noBlocksScene : PackedScene = preload("res://Scenes/Placeables/no_blocks.tscn")
var level_num : int
var level_scene : Node2D
var in_placement_mode : bool = false
var held_block : Node2D
var finish : Node2D
var playerInstanced : RigidBody2D
const rotation_step : float = deg_to_rad(10)

func prepare_level() -> void:
	match level_num:
		0:
			level_scene = load("res://Scenes/tutorial.tscn").instantiate()
		1:
			level_scene = load("res://Scenes/Levels/level1.tscn").instantiate()
		2:
			level_scene = load("res://Scenes/Levels/level2.tscn").instantiate()
		3:
			level_scene = load("res://Scenes/Levels/level3.tscn").instantiate()
		4:
			level_scene = load("res://Scenes/Levels/level4.tscn").instantiate()
		5:
			level_scene = load("res://Scenes/Levels/level5.tscn").instantiate()
		6:
			level_scene = load("res://Scenes/Levels/level6.tscn").instantiate()
		7:
			level_scene = load("res://Scenes/Levels/level7.tscn").instantiate()
		8:
			level_scene = load("res://Scenes/Levels/level8.tscn").instantiate()
		9:
			pass
		10:
			pass
	
	
	add_child(level_scene)
	finish = level_scene.finish
	in_placement_mode = false
	spawn_new_player()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not in_placement_mode:
		if Input.is_action_just_pressed("Speed up time"):
			Engine.time_scale += 0.1
		if Input.is_action_just_pressed("Slow down time"):
			Engine.time_scale -= 0.1
		Engine.time_scale = clamp(Engine.time_scale, 0, 1)
	if not in_placement_mode and Input.is_action_just_pressed("Open placement menu"):
		toggle_placement_mode()
	elif in_placement_mode and Input.is_action_just_pressed("Close placement menu"):
		toggle_placement_mode()
	if in_placement_mode:
		shadow_block_to_mouse()
		if held_block.block_type != "No blocks":
			if Input.is_action_just_pressed("Place object"):
				held_block.place_and_activate()
				cycle_block()
				$"Place block".play()
			if Input.is_action_just_pressed("Change block"):
				change_block()
				$"Scroll block".play()
			if Input.is_action_just_pressed("Rotate object clockwise"):
				rotate_block_CW()
				$"Rotate CW".play()
			if Input.is_action_just_pressed("Rotate object counter-clockwise"):
				rotate_block_CCW()
				$"Rotate CCW".play()
		shadow_block_to_mouse()
	if finish:
		if finish.finished:
			playerInstanced.process_mode = Node.PROCESS_MODE_DISABLED
	if Input.is_action_just_pressed("Reset"):
		reset_level()

func spawn_new_player() -> void:
	playerInstanced = playerScene.instantiate()
	var cameraInstanced = cameraScene.instantiate()
	level_scene.add_child(playerInstanced)
	playerInstanced.add_child(cameraInstanced)
	playerInstanced.global_position = $"Environment/Player spawnpoint".global_position
	playerInstanced.heldCamera = cameraInstanced
	
func delete_and_spawn_player_at_coords_with_transforms(coords: Vector2) -> void:
	var transf : Transform2D = playerInstanced.transform
	var ang_velo : float = playerInstanced.angular_velocity
	var lin_vel : Vector2 = playerInstanced.linear_velocity
	playerInstanced.queue_free()
	playerInstanced = playerScene.instantiate()
	var cameraInstanced = cameraScene.instantiate()
	level_scene.add_child(playerInstanced)
	playerInstanced.add_child(cameraInstanced)
	playerInstanced.transform = transf
	playerInstanced.angular_velocity = ang_velo
	playerInstanced.linear_velocity = lin_vel
	playerInstanced.global_position = coords
	playerInstanced.heldCamera = cameraInstanced
	
	

func toggle_placement_mode() -> void:
	if in_placement_mode:
		in_placement_mode = false
		level_scene.remove_child(held_block)
		held_block = null
	else:
		in_placement_mode = true
		get_first_block()
		
	
func shadow_block_to_mouse() -> void:
	if held_block:
		var mouse_position = get_global_mouse_position()
		held_block.global_position = mouse_position
	
func cycle_block() -> void:
	level_scene.placeable_blocks.pop_front()
	get_first_block()
	
func rotate_block_CW() -> void:
	held_block.rotate(rotation_step)
	
func rotate_block_CCW() -> void:
	held_block.rotate(-rotation_step)
	
func get_first_block() -> void:
	held_block = level_scene.placeable_blocks.front()
	if held_block:
		level_scene.add_child(held_block)
	else:
		held_block = noBlocksScene.instantiate()
		level_scene.add_child(held_block)

func reset_level() -> void:
	level_scene.queue_free()
	prepare_level()
	
func change_block() -> void:
	level_scene.remove_child(held_block)
	var tmp : Node2D = level_scene.placeable_blocks.pop_front()
	level_scene.placeable_blocks.append(tmp)
	get_first_block()
