extends Node2D

@onready var chip_overide:bool = false
@onready var rarity:String = "uncommon"
@onready var logo:Texture = $logo.texture
func chip_method():
	var morale_container:int = 1
	var board:Node2D = get_parent().get_parent()
	board.get_parent().get_node("balance").end_day_status()
func inverse_chip_method():
	pass
