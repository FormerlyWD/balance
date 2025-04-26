extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"buy"
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"+",
	"value",
	" Experience.",
	" -1",
	" Morale"
]
var all_comps:Dictionary = {
	"value": 1
}
@onready var chip_unique_name:String
var exp_container:int
var chip_spawn:Node2D
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	var board:Node2D = get_parent().get_parent()
	if one_shot:
		chip_unique_name = name + str(board.board_occupation.keys().size())
		one_shot = false
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	signalst.emit_signal("morale_addition", -1, "Work(project)")
	info.all_currency["Experience"] += all_comps["value"]
	exp_container += all_comps["value"]
	chip_spawn = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	chip_spawn.remove_positive("Work(project)",false)
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	signalst.emit_signal("remove_container","Work(project)")
	info.all_currency["Experience"] -= exp_container
