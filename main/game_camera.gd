extends Camera2D
@export var decay:float = 0.8
@export var max_offset:Vector2 = Vector2(100,75)
@export var max_roll: float = 0.1
@onready var follow_node:Node2D = %board
var trauma:float = 0.0
var trauma_power:int = 2

func shake():
	var amount = pow(trauma,trauma_power)
	rotation = max_roll
	offset.x = max_offset.x * amount * info.rng.randf_range(-1,1)
	offset.y = max_offset.y * amount * info.rng.randf_range(-1,1)
func add_trauma(amount:float):
	trauma = min(trauma + amount, 1.0)
	

func _process(delta: float) -> void:
	if follow_node:
		global_position = follow_node.global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
func _ready() -> void:
	var camera_change:Callable = Callable(self, "camera_change")
	signalst.connect("camera_change", camera_change)
	signalst.connect("shake_camera",Callable(self,"add_trauma"))

func camera_change(zoom_level:float):
	zoom = Vector2.ONE*zoom_level
	
func unzoom(unzoom_scale:float):
	var new_zoom_value = zoom /unzoom_scale

	var old_resolution = info.resolution /zoom
	var new_resolution = info.resolution / new_zoom_value
	
	var new_tween:Tween = create_tween()
	new_tween.tween_property(self,"zoom",new_zoom_value,0.50).set_trans(Tween.TRANS_BOUNCE)

	
