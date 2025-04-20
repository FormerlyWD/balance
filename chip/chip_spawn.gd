extends Node2D

@onready var sample_chip:PackedScene = preload("res://chip/sample_chip.tscn")
@onready var shop_sample_squares:PackedScene = load("res://UI related stuff/shop_squares.tscn")
@onready var logo:Texture = load( "res://art_folder/chips/logos/Sprite-0005.png")


@onready var turn:int = 1
func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		if %selector.selected_element:
			spawn_chip()
func spawn_chip():
	
	if %board.board_squares[%selector.selected_element] in %board.board_occupation.keys():
		return
	if %board.currently_shifting:
		return
	
	var new_chip:Node2D = sample_chip.instantiate()
	var new_chip_format:Node2D 
	var color:bool
	if turn % 2 ==0:
		color = false
		new_chip_format = fetch_next_chip(info.negative_draw_pile)
		
	else:
		new_chip_format = fetch_next_chip(info.positive_draw_pile)
		color = true
		
	%selector.selected_element.add_child(new_chip)
	new_chip.format(color, new_chip_format.rarity, new_chip_format.logo)
	new_chip.global_position = %selector.selected_element.global_position
	%board.board_occupation[%board.board_squares[%selector.selected_element]] = new_chip
	new_chip.set_script(new_chip_format.get_script())
	new_chip.chip_method()
	signalst.emit_signal("chip_spawn", %board.board_squares[%selector.selected_element])
	turn+=1
func fetch_next_chip(chip_array:Array[String]) -> Node2D:
	if chip_array.size() == 0:
		return info.all_chip_names["Blank"]
	var chip = info.all_chip_names[chip_array[0]]
	chip_array.remove_at(0)
	return chip
func instanciate_preview_chip(chip_name:String) -> Node2D:
	
	return info.all_chip_names[chip_name]
func position_preview_chip(possible_chips:Array[String], square:Node2D):
	var rng = RandomNumberGenerator.new()
	var chosen_chip:String = possible_chips[rng.randi_range(0,possible_chips.size()-1)]
	var new_chip:Node2D = sample_chip.instantiate()
	var instanciated_chip = info.all_chip_names[chosen_chip]
	new_chip.format(true, instanciated_chip.rarity, instanciated_chip.logo)
	new_chip.global_position = square.global_position
	
func summon_shop_squares():
	var length:int = 5
	var x_count:int = 0
	var all_possible_chips:Array[String] = [
		"Blank",
		"Study",
		"Sleep"
	]
	for squares in length:
		var square_px:int = 25
		var square_scale:int = 2
		var instanciated_square:Node2D = shop_sample_squares.instantiate()
		add_child(instanciated_square)
		instanciated_square.position = Vector2(x_count*square_px*square_scale,0)
		instanciated_square.instantiate(all_possible_chips)
		x_count +=1
