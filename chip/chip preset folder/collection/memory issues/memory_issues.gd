extends Node2D
@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"buy",
	"sided"
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String] 
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"Disable the chip to the left"
]
var all_comps:Dictionary = {
	"value": 1
}
var one_shot:bool = true
var chip_management_node:Node
var board:Node2D 
var index:Vector2i
func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	board = get_parent().get_parent()
	chip_management_node = get_parent().get_parent().get_parent().get_node("chip_management")
	index = board.board_occupation.find_key(self)
	var chip_right:Vector2i = Vector2i(
		index+Vector2i.LEFT
	)
	
	if chip_right in board.board_occupation.keys():
		chip_management_node.get_node("chip_method").disable(board.board_occupation[chip_right])
	else:
		if one_shot:
			var chip_spawn:Callable = Callable(self, "chip_spawn")
			signalst.connect("chip_spawn", chip_spawn)
			one_shot = false
	chip_management_node.get_node("chip_spawn").remove_positive("Confused",false)
func chip_spawn(chip_index:Vector2i):
	if blocked_actions.has("disabled"):
		return
	if chip_index in board.board_occupation.keys():
		chip_management_node.get_node("chip_method").disable(board.board_occupation[chip_index])
		signalst.disconnect("chip_spawn", chip_spawn)
		
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	var chip_right:Vector2i = Vector2i(
		index+Vector2i.LEFT
	)
	if chip_right in board.board_occupation.keys():
		chip_management_node.get_node("chip_method").enable(board.board_occupation[chip_right])
