extends Node2D

@onready var selected_element:Node2D
@onready var is_selecting:bool = false
@onready var is_disabled:bool = false
func _ready() -> void:
	
	visible = false
	$blockslctanim.play("default")
	var selectcallable:Callable = Callable(self, "on_select")
	select.connect("selected_block",selectcallable)
	var reevalcallable:Callable = Callable(self, "reevaluate_block")
	signalst.connect("chip_spawn",reevalcallable)

func on_select(block_reference:Node2D)-> void:
	

	is_selecting = true
	if is_disabled:
		return
	visible = true 
	global_position = block_reference.global_position
	selected_element = block_reference

	if selected_element.get_child_count() > 2:
		%descripter.get_description(selected_element.get_child(2))
		selected_element.get_child(2)
	else:
		%descripter.empty_description()
func reevaluate_block(block_location:Vector2i):
	if selected_element == %board.board_squares.find_key(block_location):
		%descripter.get_description(selected_element.get_child(2))
