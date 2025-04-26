extends Node2D
@onready var sample_chip:PackedScene = preload("res://chip/sample_chip.tscn")
@onready var shop_sample_squares:PackedScene = preload("res://UI related stuff/shop_squares.tscn")
@onready var offset:Vector2 = Vector2(
	-80,
	-40
)
@onready var all_chips_array:Dictionary
@onready var last_chip_count:int = 0
@onready var last_y_count:int = 0
@onready var capped_y_count:int = 4
func create_chips(temporary_draw_pile:Array[String]):
	print(global_position)
	var chip_count:int = last_chip_count
	var y_count:int = last_y_count

	for chip_string in temporary_draw_pile:
		if chip_count == 5:
			chip_count = 0
			y_count +=1
		var new_chip_format:Node2D = %chip_presets.get_all_chips_and_names()[chip_string]
		var new_chip:Node2D = sample_chip.instantiate()
		var shop_square:Node2D = shop_sample_squares.instantiate()
		all_chips_array[shop_square] = chip_string
		add_child(shop_square)
		shop_square.add_child(new_chip)
		shop_square.scale = Vector2.ONE
		new_chip.name = new_chip_format.name
		new_chip.format(true, new_chip_format.rarity, new_chip_format.logo, true)
		shop_square.stored_chip = new_chip_format.name
		

		shop_square.position = Vector2(
			offset.x+(10*chip_count*scale.x*new_chip.scale.x)+1*chip_count,
			offset.y+(10*y_count*scale.x*new_chip.scale.x)+3*y_count
		)
		chip_count +=1
	last_chip_count = chip_count
	last_y_count =y_count
	

			
func _ready() -> void:
	create_chips(info.positive_draw_pile)
