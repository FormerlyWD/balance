extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"buy",
	"Blank"
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"does nothing"
]
var all_comps:Dictionary = {
	"value": 1
}
@onready var chip_unique_name:String
var one_shot = true
func chip_method(retrigger:bool = false)-> void:
	if one_shot:
		one_shot = false
		var board:Node2D = get_parent().get_parent()
		chip_unique_name = name + str(board.board_occupation.keys().size())
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	if info.worse_blanks:
		description_structure = [
			"-",
			"value",
			" Morale.",
			" you regret the times you've wasted."
		]

		signalst.emit_signal("morale_addition", -all_comps["value"], chip_unique_name)
		name = "Regretful Blank"
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	if info.worse_blanks:
		signalst.emit_signal("remove_container", chip_unique_name)
