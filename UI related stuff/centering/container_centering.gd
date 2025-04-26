extends Node2D

func center_list():
	var rectangle_shape:RectangleShape2D = $text_area/area.shape
	var container_length:float = rectangle_shape.get_rect().size.y
	var spacing:float = 20.0
	
func _ready() -> void:
	center_list()
