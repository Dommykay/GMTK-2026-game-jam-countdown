extends Node2D

const rock : PackedScene = preload("res://Scenes/rock.tscn")
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _on_rock_cooldown_timeout() -> void:
	spawn_rock()

func spawn_rock() -> void:
	var rock_instance : RigidBody2D = rock.instantiate()
	rock_instance.global_transform = global_transform
	var	random_num : float = rng.randf_range(-100,100)
	var random_num_2 : float = rng.randf_range(-500,100)
	rock_instance.linear_velocity = Vector2(random_num, random_num_2)
	add_child(rock_instance)
	
