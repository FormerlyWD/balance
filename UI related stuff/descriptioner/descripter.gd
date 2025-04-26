extends Node2D

@onready var positioning:Vector2 = Vector2(-33,12)
@onready var sample_chip:PackedScene = preload("res://chip/sample_chip.tscn")
@onready var occupied_chip:Node2D = $chip
@onready var scaling:int = 4
func get_description(chip:Node2D):
	var empty_string:String
	for element in chip.description_structure:
		if chip.all_comps.has(element):
			empty_string += str(chip.all_comps[element])
		else:
			empty_string += element
	$description.text = empty_string
	occupied_chip.queue_free()
	var new_chip:Node2D = chip.duplicate()
	add_child(new_chip)
	occupied_chip = new_chip
	new_chip.position = positioning
	new_chip.scale = Vector2.ONE*scaling
	if info.all_chip_names == null:
		
		$name.text = %chip_presets.get_all_chips_and_names().find_key(chip)

	else:

		$name.text  = chip.name 
func get_dillema_description(dilemma:Node2D):
	
	$name.text = dilemma.get_child(0).d_name
	$description.text = dilemma.get_child(0).description
	occupied_chip.queue_free()
	var new_dillema:Node2D = dilemma.duplicate()
	new_dillema.get_node("name").queue_free()
	add_child(new_dillema)
	
	occupied_chip = new_dillema
	occupied_chip.position = positioning
	occupied_chip.scale = Vector2.ONE*scaling
	
	
func empty_description():
	$description.text = "Please select a Chip, or create one by pressing Left Click on an empty Square."
	occupied_chip.queue_free()
	var new_chip:Node2D = sample_chip.instantiate()
	occupied_chip = new_chip
	add_child(new_chip)
	new_chip.position = positioning
	new_chip.scale = Vector2.ONE*scaling
	$name.text = ""
