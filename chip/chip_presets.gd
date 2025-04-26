extends Node

@onready var all_chips:Array[Node] = get_children()
@onready var all_chip_names:Dictionary = get_all_chips_and_names()
@onready var all_chip_with_rarity:Dictionary = get_all_chips_and_rarity()

func _ready() -> void:
	info.all_chips = all_chips
	if not info.is_chip_listed:
		info.all_chip_names = get_all_chips_and_names()
		info.all_chip_rarities = get_all_chips_and_rarity() 
		info.is_chip_listed = true
func get_all_chips_and_names() -> Dictionary:
	var dictionary_container:Dictionary
	for chip in all_chips:
		dictionary_container[chip.name]= chip
	return dictionary_container
	
func get_all_chips_and_rarity() -> Dictionary:
	var empty_dict:Dictionary
	for rarity in info.rarities_and_rate.keys():
		empty_dict[rarity] = []
	
	for chips in all_chips:
		if not chips.blocked_actions.has("sided"):
			empty_dict[chips.rarity].append(chips)
	return empty_dict
func get_all_chips_and_rarity_neg() -> Dictionary:
	var empty_dict:Dictionary
	for rarity in info.rarities_and_rate.keys():
		empty_dict[rarity] = []
	
	for chips in all_chips:
		if  chips.blocked_actions.has("sided"):
			empty_dict[chips.rarity].append(chips)
	return empty_dict	
			
func get_random_chip_set(from_to:Vector2i):
	var rng= RandomNumberGenerator.new()
	var array_container:Array[String]
				
	
	return
