extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String]= ["buy",
	"sided"]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"-",
	"value",
	" Morale"
]
var all_comps:Dictionary = {
	"value": 5
}
@onready var morale_container:int = 0
@onready var chip_unique_name:String
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	var board:Node2D = get_parent().get_parent()
	if one_shot:
		chip_unique_name = name + str(board.board_occupation.keys().size())
		one_shot = false
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	morale_container +=-all_comps["value"]
	signalst.emit_signal("morale_addition", -all_comps["value"], chip_unique_name)
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	signalst.emit_signal("remove_container",chip_unique_name)
