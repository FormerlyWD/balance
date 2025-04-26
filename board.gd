extends Node2D

@export var square_px:int
@export var square_scale:int = 2
@export var true_texture:Texture = load("res://art_folder/board/Sprite-0004.png")
@export var false_texture:Texture = load("res://art_folder/board/Sprite-0003.png")
var square_textures:Dictionary = {
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
func instanciate_square(dimention:Vector2i, sqr_position:Vector2, board_color:bool) -> void:
	var new_square:Node2D = board_square_preset.instantiate()
	add_child(new_square)
	board_squares[new_square] = dimention
	new_square.global_position = sqr_position
	if board_color:
		new_square.get_child(0).get_child(0).color = Color.html("6c2940")
		new_square.get_child(0).texture = square_textures[board_color]
func instianciate_all_squares():
	check_if_too_large(dimentions)
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
				-(-y_offset+((y_count*square_px)*square_scale))
			)
			var dimention:Vector2i = Vector2i(
				x_count,
				y_count
			)
			if x_count == 1:
				pass
			instanciate_square(dimention,sqr_position, board_color_toggle)
			x_count += 1
			board_color_toggle = not board_color_toggle
		if reload_type:
			board_color_toggle = not board_color_toggle
		y_count += 1
		
func create_new_squares(new_resolution:Vector2i, orientation_transition_type:String):
	pass
func get_square_rect(dimentions:Vector2i):
	var default_square_unit:float = square_px*square_scale*%game_camera.zoom.x*2
	return dimentions*default_square_unit
func check_if_too_large(dimentions:Vector2i):
	var rect:Vector2 = get_square_rect(dimentions)

	if rect.x > info.resolution.x:
	
		%game_camera.unzoom(rect.x/info.resolution.x)
	elif rect.y > info.resolution.y:
		%game_camera.unzoom(rect.y/info.resolution.y)
	
func update_all_sqr_position(dimention_addition:Vector2i):
	print("fg")
	var old_x_offset:float = update_offset("x")
	var old_y_offset:float = update_offset("y")
	var old_dimention:Vector2i = dimentions
	check_if_too_large(dimentions+dimention_addition)
	dimentions += dimention_addition
	signalst.emit_signal("dimention_update", dimentions, dimention_addition)
	var x_offset:float = update_offset("x")
	var y_offset:float = update_offset("y")
	var new_tween:Tween = self.create_tween()
	var reload_type:bool = true
	
	new_tween.tween_property(self,"position",Vector2((old_x_offset-x_offset)+position.x, (y_offset-old_y_offset)+position.y),1).set_trans(Tween.TRANS_ELASTIC)


	%board.currently_shifting = true
	%selector.visible = false
	%selector.is_disabled = true
	await new_tween.finished
	%selector.global_position = Vector2.ONE*1000000
	%selector.visible = true
	%selector.is_disabled = false
	%board.currently_shifting = false
	
	
	if dimentions.x - old_dimention.x > 0:
		var x_row:int = 0
		var y_count:int  = 0
		if old_dimention.y % 2 ==0:
			reload_type = true
		else:
			reload_type = false
		if old_dimention.x % 2 == 0:
			board_color_toggle = true
		else:
			board_color_toggle = false
		for all_rows in dimention_addition.x:
			for all_squares in dimentions.y:
				print(y_count)
				var dimention:Vector2i = Vector2i(
					old_dimention.x+x_row,
					y_count
				)
				var sqr_position:Vector2 = Vector2(
					-x_offset+((old_dimention.x+x_row)*square_px*square_scale),
					-(-y_offset+((y_count)*square_px*square_scale))
				)
				y_count += 1
				instanciate_square(dimention,sqr_position, board_color_toggle)
				board_color_toggle = not board_color_toggle
			if  reload_type:
				board_color_toggle = not board_color_toggle
			y_count = 0
			x_row +=1

	if dimention_addition.y > 0:
		var y_row:int = 0
		var x_count:int  = 0
		if old_dimention.y % 2 ==0:
		
			board_color_toggle = true
		else:
	
			board_color_toggle = false
		if dimention_addition.x % 2 == 0:
			reload_type = true
		else:
			reload_type = false
		for all_rows in dimention_addition.y:
			for all_squares in dimentions.x:
				var dimention:Vector2i = Vector2i(
					x_count,
					old_dimention.y+y_row
				)
				var sqr_position:Vector2 = Vector2(
					-x_offset+((x_count)*square_px*square_scale),
					-(-y_offset+((y_row+old_dimention.y)*square_px*square_scale))
				)
				x_count += 1
				instanciate_square(dimention,sqr_position, board_color_toggle)
				print(board_color_toggle)
				board_color_toggle = not board_color_toggle
			if reload_type:
				board_color_toggle = not board_color_toggle
			x_count = 0
			y_row +=1
func _ready() -> void:
	var new_dimention:Vector2i = Vector2i(
		4,
		4
	) * info.random_board_gen_modifier
	dimentions = new_dimention
	instianciate_all_squares()
	var reorder_dim:Callable = Callable(self, "update_all_sqr_position")
	signalst.connect("reorder_dimention", reorder_dim)
#info.rng.randi_range(3,4),
		#info.rng.randi_range(3,4)
