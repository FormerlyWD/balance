extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"buy",
	"sided",
	"gettable"
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"-",
	"value",
	" Morale.",
	"+",
	"buff",
	" Buff each turn.",
	" Buff value doubles each turn "
]
var all_comps:Dictionary = {
	"value": 5,
	"buff":1
}
@onready var chip_unique_name:String
var chip_management_node:Node
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	var board:Node2D = get_parent().get_parent()
	if one_shot:
		chip_unique_name = name + str(board.board_occupation.keys().size())
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	chip_management_node = get_parent().get_parent().get_parent().get_node("chip_management")
	signalst.emit_signal("morale_addition", -all_comps["value"], chip_unique_name)
	if one_shot:
		signalst.connect("new_turn",Callable(self,"new_turn"))
		one_shot = false
	var chip_spawn:Node2D
	chip_spawn = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	chip_spawn.remove_positive("Depression",false)
func new_turn():
	print("newturn")
	chip_management_node.get_node("chip_method").buff(self,all_comps["buff"])
	all_comps["buff"] *= 2
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	signalst.emit_signal("remove_container",chip_unique_name)
