extends Node2D
@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos") 
@export var blocked_actions:Array[String]= ["buy",
	"drawn"]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"add ",
	"value",
	" Sadness chip(s)",
	" to temporary draw pile.",
	" Single-use"
]
var all_comps:Dictionary = {
	"value": 3
}
var one_shot:bool = false
@onready var chip_spawn:Node2D
func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return

	chip_spawn = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	for all_party_range in all_comps["value"]:
		chip_spawn.add_negative("Sadness")
	chip_spawn.remove_positive("Rejected(job)",false)


func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	for all_party_range in all_comps["value"]:
		chip_spawn.remove_negative("Party")
		
