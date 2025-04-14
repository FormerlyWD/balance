extends Node2D

@export var square_px:int
@export var square_scale:int = 2
@export var true_texture:Texture = load("res://art_folder/board/Sprite-0004.png")
@export var false_texture:Texture = load("res://art_folder/board/Sprite-0003.png")
@onready var square_textures:Dictionary = {
	true: true_texture,
	false: false_texture
}
@onready var board_square_preset:PackedScene = preload("res://main/board_components/board_square.tscn")
var board_color_toggle:bool = true



#---
@onready var offset:float
@onready var dimentions:Vector2i = Vector2i(2,3)
@onready var board_squares:Dictionary = {
	
}


func get_size_sum(dim:String) -> float:

	if dim == "x":
		return square_px*square_scale*dimentions.x
	elif dim == "y":
		return square_px*square_scale*dimentions.y
	else:
		return -1


func update_offset(dim:String) -> float:
	return get_size_sum(dim)/2
func reorder_square():
	pass
func instanciate_square(dimention:Vector2i, sqr_position:Vector2) -> void:
	var new_square:Node2D = board_square_preset.instantiate()
	add_child(new_square)
	board_squares[new_square] = dimention
	new_square.position = sqr_position
	new_square.get_child(0).texture = square_textures[board_color_toggle]
	board_color_toggle = not board_color_toggle
func instianciate_all_squares():
	var x_offset:float = update_offset("x")
	var x_count:int =0
	var y_offset:float = update_offset("y")
	var y_count:int =0
	var color:bool = true
	for y in dimentions.y:

		x_count = 0
		for x in dimentions.x:
			
			var sqr_position:Vector2 = Vector2(
				((x_count*square_px)+x_offset)*2,
				((y_count*square_px)+y_offset)*2
			)
			var dimention:Vector2i = Vector2i(
				x_count,
				y_count
			)
			instanciate_square(dimention,sqr_position)
			color = not color
			x_count += 1
		y_count += 1
func _ready() -> void:
	instianciate_all_squares()
