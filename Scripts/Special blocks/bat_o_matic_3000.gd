extends Node2D

const block_type : String = "Bat-o-matic 3000"
@export var hit_force : float = 1500

var mode : bool = false # 0 is winding, 1 is releasing
var now_resting : bool = false
var placed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not placed:
		modulate.a = (1.7+sin(Time.get_ticks_usec()/500000.0))/4
	else:
		if mode == false and $"Texture/Restart timer".is_stopped():
			$Texture/Bat.rotate(0.5*delta)
			if $Texture/Bat.rotation_degrees > 90:
				mode = true
				$Texture/Whoosh.play()
				update_hitbox_monitoring()
				$"Texture/Hitbox timer".start()
				$"Texture/Restart timer".start()
		elif not now_resting:
			if $Texture/Bat.rotation_degrees > 0:
				$Texture/Bat.rotate(-10*delta)
			else:
				$Texture/Bat.rotation_degrees = 0
				now_resting = true
		if now_resting and $"Texture/Restart timer".is_stopped():
			now_resting = false


func place_and_activate() -> void:
	placed = true
	modulate.a = 1.0

func calculate_force() -> Vector2:
	if $"Texture/Hit cooldown".is_stopped():
		$"Texture/Hit cooldown".start()
		$Texture/Hit.play()
		return Vector2(0,-1).rotated(global_rotation) * hit_force
	else:
		return Vector2(0,0)


func _on_hitbox_timer_timeout() -> void:
	mode = false
	update_hitbox_monitoring()
	
func update_hitbox_monitoring() -> void:
	$Texture/Hitbox.monitoring = mode
	$Texture/Hitbox.monitorable = mode


func _on_hitbox_area_entered(area: Area2D) -> void:
	area.get_parent().linear_velocity += calculate_force()
