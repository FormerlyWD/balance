extends Node2D
@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"+",
	"value",
	" Morale.",
	" Retriggering this will give you double points."
]
var all_comps:Dictionary = {
	"value": 3
}
@onready var chip_unique_name:String
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	if one_shot:
		one_shot = false
		var board:Node2D = get_parent().get_parent()
		print("FGHyoo??")
		chip_unique_name = name + str(board.board_occupation.size())
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	if retrigger:
		signalst.emit_signal("morale_addition", all_comps["value"]*2, chip_unique_name)
		return
	signalst.emit_signal("morale_addition", all_comps["value"], chip_unique_name)
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	print("you have to be kidding me...")
	if one_shot:
		blocked_actions.append("late_recall")
	signalst.emit_signal("remove_container", chip_unique_name)
