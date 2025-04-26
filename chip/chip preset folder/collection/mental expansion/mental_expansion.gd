extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"retrigger"
]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"+",
	"value",
	" Permanant rows"
]
var all_comps:Dictionary = {
	"value": 1
}
func chip_method(retrigger:bool = false):
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	var morale_container:int = 1
	var board:Node2D = get_parent().get_parent()
	board.update_all_sqr_position(Vector2i(all_comps["value"],0))
func inverse_chip_method(retrigger:bool = false):
	pass
