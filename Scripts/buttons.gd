extends TextureButton

@export var scale_intensity : float = 1.2
@export var twist_range : float = 10 #means up to 5 deg either way
@export var tween_duration : float = 0.25
var not_hovered_for_more_than_one_frame : bool = false
var hovered_for_at_least_one_frame : bool = false
var next_twist : float = randf_range(-(twist_range/2), twist_range/2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset_ratio = Vector2(0.5,0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	button_hovered()
	
	
func start_tween(property: String, final_value: Variant, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, property, final_value, duration)
	
func button_hovered() -> void:
	if is_hovered():
		not_hovered_for_more_than_one_frame = false
		if not hovered_for_at_least_one_frame:
			hovered_for_at_least_one_frame = true
			$Tick.play()
		z_index = 1
		start_tween("scale", Vector2.ONE * scale_intensity, tween_duration)
		start_tween("rotation_degrees", next_twist, tween_duration)
	else:
		if not not_hovered_for_more_than_one_frame:
			not_hovered_for_more_than_one_frame = true
			next_twist = randf_range(-(twist_range/2), twist_range/2)
		hovered_for_at_least_one_frame = false
		z_index = 0
		start_tween("scale", Vector2.ONE, tween_duration)
		start_tween("rotation_degrees", 0, tween_duration)
