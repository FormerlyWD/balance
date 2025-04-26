extends Node2D
@onready var selected_element:Node2D
@onready var is_selecting:bool = false
@onready var is_disabled:bool = false
@onready var selected_dillema:Node2D 
func _ready() -> void:
	
	visible = false
	$blockslctanim.play("default")
	var selectcallable:Callable = Callable(self, "on_select")
	select.connect("shop_select",selectcallable)
func on_select(block_reference:Node2D)-> void:
	if block_reference.store_item_type == "Chip":
		%descripter.get_description(%chip_presets.get_all_chips_and_names()[block_reference.stored_chip])
		%price.text = block_reference.get_node("Area2D").get_node("Label").text
		scale = Vector2.ONE*3
	else:
		%price.text = ""
		%descripter.get_dillema_description(block_reference)
		
		scale = Vector2.ONE*1.25
	print("HOWMACH")
	is_selecting = true
	if is_disabled:
		return
	visible = true
	global_position = block_reference.global_position
	selected_element = block_reference
func deselect():
	visible = false
	is_selecting = false
	
func cannot_do_animation():
	$blockslctanim.play("red")
	await $blockslctanim.animation_finished
	$blockslctanim.play("default")
