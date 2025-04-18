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
@export var dimentions:Vector2i = Vector2i(2,3)
@onready var board_squares:Dictionary = {
	
}
@onready var board_occupation:Dictionary = {
	
}

@onready var currently_shifting:bool = false

func get_size_sum(dim:String) -> float:

	if dim == "x":
		return square_px*square_scale*(dimentions.x-1)
	elif dim == "y":
		return square_px*square_scale*(dimentions.y-1)
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
	new_square.global_position = sqr_position
	new_square.get_child(0).texture = square_textures[board_color_toggle]
func instianciate_all_squares():
	var x_offset:float = update_offset("x")
	var x_count:int =0
	var y_offset:float = update_offset("y")
	var y_count:int =0
	var reload_type:bool = true
	if dimentions.x % 2 ==0:
		reload_type = true
	else:
		reload_type = false
	for y in dimentions.y:
		x_count = 0
		for x in dimentions.x:
			var sqr_position:Vector2 = Vector2(
				(-x_offset+(((x_count*square_px)*square_scale))),
				(-y_offset+((y_count*square_px)*square_scale))
			)
			print(-x_offset+x_count*square_px*square_scale)
			var dimention:Vector2i = Vector2i(
				x_count,
				y_count
			)
			if x_count == 1:
				pass
			instanciate_square(dimention,sqr_position)
			x_count += 1
			board_color_toggle = not board_color_toggle
		if reload_type:
			board_color_toggle = not board_color_toggle
		y_count += 1
		
func create_new_squares(new_resolution:Vector2i, orientation_transition_type:String):
	pass
	
func update_all_sqr_position():
	var old_x_offset:float = update_offset("x")
	var old_y_offset:float = update_offset("y")
	dimentions.x += 1
	var x_offset:float = update_offset("x")
	var y_offset:float = update_offset("y")
	var new_tween:Tween = get_tree().create_tween()
	var reload_type:bool = true
	new_tween.tween_property(self,"position",Vector2((old_x_offset-x_offset)+position.x, (old_y_offset-y_offset)+position.y),1).set_trans(Tween.TRANS_ELASTIC)
	var y_count:int = 0
	
	%board.currently_shifting = true
	%selector.visible = false
	%selector.is_disabled = true
	await new_tween.finished
	%selector.global_position = Vector2.ONE*1000000
	%selector.visible = true
	%selector.is_disabled = false
	%board.currently_shifting = false
	
	for new_squares in dimentions.y:
		var dimention:Vector2i = Vector2i(dimentions.x-1, y_count)
		var sqr_position:Vector2 = Vector2(
			-x_offset+(((dimentions.x-1)*square_px)*square_scale),
			-y_offset+((y_count*square_px)*square_scale)
		)
		instanciate_square(dimention,sqr_position)
		board_color_toggle = not board_color_toggle
		y_count +=1
		
func _ready() -> void:
	instianciate_all_squares()
	var reorder_dim:Callable = Callable(self, "update_all_sqr_position")
	signalst.connect("reorder_dimention", reorder_dim)
