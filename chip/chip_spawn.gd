extends Node2D

@onready var sample_chip:PackedScene = preload("res://chip/sample_chip.tscn")
@onready var shop_sample_squares:PackedScene = load("res://UI related stuff/shop_squares.tscn")
@onready var logo:Texture = load( "res://art_folder/chips/logos/Sprite-0005.png")

@onready var temporary_positive_draw_pile:Array[String]
@onready var temporary_negative_draw_pile:Array[String]
@onready var all_chips_positive_pile:Array[String]
@onready var all_chips_negative_pile:Array[String]
@onready var game_resuming:bool = true
@export var offset:float  = -50
@onready var count:int = 0
@onready var turn:int = 1

func _ready() -> void:
	temporary_positive_draw_pile = info.positive_draw_pile.duplicate()
	temporary_positive_draw_pile.shuffle()
	all_chips_positive_pile = temporary_positive_draw_pile.duplicate()
	temporary_negative_draw_pile = info.negative_draw_pile.duplicate()
	temporary_negative_draw_pile.shuffle()
	all_chips_negative_pile = temporary_negative_draw_pile.duplicate()
func add_positive(string:String,temp:bool = true):
	if temp:
		temporary_positive_draw_pile.append(string)
	else:
		temporary_positive_draw_pile.append(string)
		info.positive_draw_pile.append(string)
	all_chips_positive_pile.append(string)
func remove_positive(string:String,temp:bool = true):
	print(string + " erstsgd")
	if temp:
		if temporary_positive_draw_pile.has(string):
			print(string)
			temporary_positive_draw_pile.erase(string)
			
	else:
		if temporary_positive_draw_pile.has(string):
			temporary_positive_draw_pile.erase(string)
		if info.positive_draw_pile.has(string):
			print(string)
			info.positive_draw_pile.erase(string)
	if info.positive_draw_pile.has(string):
		all_chips_positive_pile.erase(string)
func remove_negative(string:String,temp:bool = true):
	if temp:
		if temporary_negative_draw_pile.has(string):
			temporary_negative_draw_pile.erase(string)
			
	else:
		if temporary_negative_draw_pile.has(string):
			temporary_negative_draw_pile.erase(string)
		if info.negative_draw_pile.has(string):
			info.negative_draw_pile.erase(string)
	if info.negative_draw_pile.has(string):
		all_chips_negative_pile.erase(string)
func add_negative(string:String,temp:bool = true):
	if temp:
		temporary_negative_draw_pile.append(string)
		
	else:
		temporary_negative_draw_pile.append(string)
		info.negative_draw_pile.append(string)
	all_chips_negative_pile.append(string)
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		if info.current_scene == "Game":
			if %selector.is_selecting:
				if %board.board_squares[%selector.selected_element] in %board.board_occupation.keys():
					return
				if %board.currently_shifting:
					return
				%clicksound.play()
				spawn_chip()
func spawn_chip():
	
	
	var new_chip:Node2D = sample_chip.instantiate()
	var new_chip_format:Node2D 
	var color:bool
	

	if turn % 2 ==1:
		color = true
		new_chip_format = fetch_next_chip(temporary_positive_draw_pile)
		
	else:
		
		new_chip_format = fetch_next_chip(temporary_negative_draw_pile,true)
		color = false
	if info.headache_count > 0:
		var new_board_squares:Dictionary = %board.board_squares.duplicate()
		for occupied_chips in %board.board_occupation.keys():
			
			new_board_squares.erase(%board.board_squares.find_key(occupied_chips))
		var keys:Array = new_board_squares.keys()
		keys.shuffle()
		%selector.selected_element = keys[0]
	%board.board_occupation[%board.board_squares[%selector.selected_element]] = new_chip
	
	%selector.selected_element.add_child(new_chip)
	
	new_chip.name = new_chip_format.name
	new_chip.format(color, new_chip_format.rarity, new_chip_format.logo)
	new_chip.global_position = %selector.selected_element.global_position
	new_chip.set_script(new_chip_format.get_script())
	signalst.emit_signal("chip_spawn", %board.board_squares[%selector.selected_element])
	print("newturn?")
	signalst.emit_signal("new_turn")
	new_chip.chip_method()
	new_chip.all_comps["side"] = true

	turn+=1
func fetch_next_chip(chip_array:Array[String], is_neg:bool = false) -> Node2D:
	if chip_array.size() == 0:
		if info.refill_draw_pile:
			if is_neg:
				if info.negative_draw_pile.size()>0:
					chip_array += info.negative_draw_pile
					return %chip_presets.all_chip_names[chip_array[0]]
			else:
				if info.positive_draw_pile.size()>0:
					chip_array += info.positive_draw_pile
					return %chip_presets.all_chip_names[chip_array[0]]
		return %chip_presets.all_chip_names["Blank"]
	var chip = %chip_presets.all_chip_names[chip_array[0]]
	chip_array.remove_at(0)
	return chip
func instanciate_preview_chip(chip_name:String) -> Node2D:
	
	return info.all_chip_names[chip_name]
func position_preview_chip(chip:Node2D, square:Node2D):
	if chip.blocked_actions.has("buy"):
		position_preview_chip(%library_set.extract_one_library_set(),square)
		return
	chip.chip_name = chip.name
	square.stored_chip = chip.name
	print(chip.name + str(" 2wewaqd"))
	var new_chip:Node2D = sample_chip.instantiate()
	square.add_child(new_chip)
	var instanciated_chip = chip.duplicate()
	chip_price(square, chip)
	new_chip.format(true, chip.rarity, chip.logo)
	new_chip.global_position = square.global_position

func summon_shop_squares():
	
	var length:int = 4
	var x_count:int = 0
	var library1:Array[String] = [
		"Blank",
		"Study",
		"Study",
		"Blank"
	]

	var all_y_axis:Array[float] = [
		-80,
		0
	]
	var square_px:int = 25
	var square_scale:int = 3
	var y_count:int = 0
	for all_axises in all_y_axis:
		
		for squares in length:
			var instanciated_square:Node2D = shop_sample_squares.instantiate()
			add_child(instanciated_square)
			var price_label:Label = instanciated_square.get_child(0).get_child(1)
			
			instanciated_square.position = Vector2(offset+(x_count*square_px*square_scale),all_y_axis[y_count])
			position_preview_chip(%library_set.extract_one_library_set(),instanciated_square)
			
			x_count +=1
		x_count = 0
		y_count +=1
func chip_price(instanciated_square:Node2D, chip:Node2D):
	var price_label:Label = instanciated_square.get_child(0).get_child(1)
	var buy_value_type:String = chip.buy_value_type
	var buy_value:int = chip.buy_value
	instanciated_square.buy_value_type = buy_value_type
	instanciated_square.buy_value = buy_value
	print(instanciated_square.buy_value_type)
	
	price_label.text = str(buy_value) + " " + "("+ instanciated_square.buy_value_type +")"
	
