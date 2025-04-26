extends Node2D


@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"buy",
	"buff",
	"sided"
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String] 
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"turn all blanks to -1 Morale blanks for this day. "
]
var all_comps:Dictionary = {
	"value": 1
}
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	info.worse_blanks = true
	var board:Node2D = get_parent().get_parent()
	for all_chips in board.board_occupation.values():
		if	all_chips.blocked_actions.has("Blank"):
			all_chips.chip_method()
	
		
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
