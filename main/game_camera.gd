extends Camera2D

func _ready() -> void:
	var camera_change:Callable = Callable(self, "camera_change")
	signalst.connect("camera_change", camera_change)

func camera_change(zoom_level:float):
	zoom = Vector2.ONE*zoom_level
