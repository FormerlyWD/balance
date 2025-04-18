extends Node2D

@onready var selected_element:Node2D
@onready var is_disabled:bool = false
func _ready() -> void:
	
	visible = false
	$blockslctanim.play("default")
	var selectcallable:Callable = Callable(self, "on_select")
	select.connect("selected_block",selectcallable)
	

func on_select(block_reference:Node2D)-> void:
	if is_disabled:
		return
	visible = true
	global_position = block_reference.global_position
	selected_element = block_reference

	
