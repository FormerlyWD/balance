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
	"Turns Cash into morale"
]
var all_comps:Dictionary = {
	"value": 1
}
var cash_container:int
@onready var chip_unique_name:String
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	var board:Node2D = get_parent().get_parent()
	if one_shot:
		chip_unique_name = name + str(board.board_occupation.keys().size())
		one_shot = false
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return

	cash_container = info.all_currency["Cash"]
	
	print()
	signalst.emit_signal("morale_addition",info.all_currency["Cash"],"Reward yourself")
	info.all_currency["Cash"] = 0
	
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	signalst.emit_signal("morale_subtraction",cash_container,"Reward yourself")
	info.all_currency["Cash"] = cash_container
