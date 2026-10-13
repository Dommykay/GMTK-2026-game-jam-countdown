extends RigidBody2D

@export var angularAccel = 20
@export var angularAccelBoost = 10
@export var jumpForce = -500
@export var maxAngularVelocity = 2000
var heldCamera : Camera2D
@onready var floorChecker = $"Floor Checker"
var dead : bool = false
signal on_death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxAngularVelocity = deg_to_rad(maxAngularVelocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tmpAccel = angularAccel
	if Input.is_action_pressed("Sprint"):
		tmpAccel += angularAccelBoost
		
		
	if Input.is_action_pressed("Move right"):
		if angular_velocity < maxAngularVelocity:
			if angular_velocity < 0:
				angular_velocity += tmpAccel * delta
			angular_velocity += tmpAccel * delta
		
	if Input.is_action_pressed("Move left"):
		if angular_velocity > -maxAngularVelocity:
			if angular_velocity > 0:
				angular_velocity -= tmpAccel * delta
			angular_velocity -= tmpAccel * delta
		
	if angular_velocity < -maxAngularVelocity or angular_velocity > maxAngularVelocity:
		lerp(angular_velocity, 0.0, 10*delta)

	if Input.is_action_just_pressed("Jump") and floorChecker.is_touching_floor():
		linear_velocity.y += jumpForce
		$Jump.play()
	if dead:
		on_death.emit()

func _on_death() -> void:
	var deadCharacterScene : PackedScene = load("res://Scenes/dead_character.tscn")
	var deadCharacter : Node2D = deadCharacterScene.instantiate()
	deadCharacter.global_transform = global_transform
	add_sibling(deadCharacter)
	var cameraScene : PackedScene = load("res://Scenes/camera.tscn")
	var camera : Camera2D = cameraScene.instantiate()
	deadCharacter.add_child(camera)
	queue_free()


func _on_hitbox_body_entered(body: Node2D) -> void:
	dead = true
