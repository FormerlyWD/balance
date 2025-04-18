extends Node2D

@onready var sample_chip:PackedScene = preload("res://chip/sample_chip.tscn")
@onready var logo:Texture = load( "res://art_folder/chips/logos/Sprite-0005.png")

@onready var positive_draw_pile:Array[String] = [
	"Mental Expansion",
	"Study",
	"Blank",
	"Blank",
	"Blank",
	"Blank",
	"Blank",
	"Blank",
	"Blank",
	"Blank"
]
func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		if %selector.selected_element:
			spawn_chip()
func spawn_chip():
	if %board.board_squares[%selector.selected_element] in %board.board_occupation.keys():
		print("finally")
		return
	if %board.currently_shifting:
		return
	
	var new_chip:Node2D = sample_chip.instantiate()
	var new_chip_format:Node2D = fetch_next_chip()
	%selector.selected_element.add_child(new_chip)
	new_chip.format(true, new_chip_format.rarity, new_chip_format.logo)
	new_chip.global_position = %selector.selected_element.global_position
	%board.board_occupation[%board.board_squares[%selector.selected_element]] = new_chip
	new_chip.set_script(new_chip_format.get_script())
	new_chip.chip_method()
	signalst.emit_signal("chip_spawn", %board.board_squares[%selector.selected_element])
func fetch_next_chip() -> Node2D:
	if positive_draw_pile.size() == 0:
		return $"../chip_presets".all_chip_names["Blank"]
	var chip = $"../chip_presets".all_chip_names[positive_draw_pile[0]]
	positive_draw_pile.remove_at(0)
	return chip
