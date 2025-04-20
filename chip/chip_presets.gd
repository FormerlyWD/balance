extends Node

@onready var all_chips:Array[Node] = get_children()


func _ready() -> void:
	info.all_chips = all_chips
	info.all_chip_names = get_all_chips_and_names()
func get_all_chips_and_names() -> Dictionary:
	var dictionary_container:Dictionary
	for chip in all_chips:
		dictionary_container[chip.name]= chip
	return dictionary_container
	
