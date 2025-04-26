extends Node

signal selected_block(block_reference:Node2D)
signal unselected_block
signal shop_select
func _ready() -> void:
	var selectcallable:Callable = Callable(self, "on_select")
	connect("selected_block",selectcallable)

func on_select(block_reference:Node2D)-> void:
	pass
	
