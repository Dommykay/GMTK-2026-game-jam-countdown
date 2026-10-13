extends StaticBody2D

var scale_change : float = 1.5
var descale_speed : float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Texture.scale = lerp($Texture.scale, Vector2(1.0,1.0), descale_speed*delta)


func _on_player_bounce(body: Node2D) -> void:
	$Texture.scale = Vector2(scale_change,scale_change)
	$Pop.play()
