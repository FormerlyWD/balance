extends Node

@onready var all_chips:Array[Node] = get_children()
@onready var all_chip_names:Dictionary = get_all_chips_and_names()

func get_all_chips_and_names() -> Dictionary:
	var dictionary_container:Dictionary
	for chip in all_chips:
		dictionary_container[chip.name]= chip
	return dictionary_container
	
