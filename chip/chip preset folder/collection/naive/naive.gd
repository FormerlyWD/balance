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
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"inverse retriggers the chip to the left",
	" (There might be a bug with this feature.)"
]
var all_comps:Dictionary = {
	"value": 1
}
var neighboring_chip:Vector2i
var chip_management_node:Node
var board:Node2D
var one_shot:bool = true
func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	chip_management_node = get_parent().get_parent().get_parent().get_node("chip_management")
	board = get_parent().get_parent()
	var index:Vector2i = board.board_occupation.find_key(self)
	neighboring_chip = index+Vector2i.LEFT
	
	if neighboring_chip in board.board_occupation.keys():
		chip_management_node.get_node("chip_method").inverse_chip_method(board.board_occupation[neighboring_chip])
	else:
		if one_shot:
			var chip_spawn:Callable = Callable(self, "chip_spawn")
			signalst.connect("chip_spawn", chip_spawn)
			one_shot = false

func chip_spawn(chip_vector:Vector2i):

	if chip_vector == neighboring_chip:
		print(board.board_occupation[chip_vector])
		print(neighboring_chip)
		chip_management_node.get_node("chip_method").inverse_chip_method(board.board_occupation[chip_vector], true)
		
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	if board.board_occupation.find_key(self)+Vector2i.LEFT in board.board_occupation.keys():
		chip_management_node.get_node("chip_method").chip_method(board.board_occupation[neighboring_chip])
		
