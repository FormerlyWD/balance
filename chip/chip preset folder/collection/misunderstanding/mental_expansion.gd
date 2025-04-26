extends Node2D
@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture



@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	"retrigger",
	"buy",
	"sided"
]

@export var buff_value:int
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"+",
	"value",
	" Morale",
	" for each Neighboring Chip"
]
var all_comps:Dictionary = {
	"value": 1
}

@onready var all_neighbors:Array[Vector2i]
@onready var neighbor_initiated:bool = false
var one_shot:bool = true
@onready var flagged_container:Array[Node2D]
@onready var chip_spawn_node:Node2D
@onready var chip_management_node:Node
@onready var board:Node2D
func chip_method(retrigger:bool = false) -> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return

	chip_spawn_node = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	chip_management_node = get_parent().get_parent().get_parent().get_node("chip_management")
	
	board = get_parent().get_parent()
	var index:Vector2i = board.board_occupation.find_key(self)
	all_neighbors = [
		Vector2i(1,0)+index,
		Vector2i(-1,0)+index,
		Vector2i(1,1)+index,
		Vector2i(0,1)+index,
		Vector2i(-1,1)+index,
		Vector2i(0,-1)+index,
		Vector2i(1,-1)+index,
		Vector2i(-1,-1)+index
		
	]
	neighbor_initiated = true
	for neighbor in all_neighbors:
		if neighbor in board.board_occupation.keys():
			flagged_container.append(get_parent().get_parent().board_occupation[neighbor])
			chip_management_node.get_node("chip_method").inverse_chip_method(board.board_occupation[neighbor],true)
	if one_shot:
		var chip_spawn:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawn)
		one_shot = false

func chip_spawn(chip_index:Vector2i):
	if blocked_actions.has("disabled"):
		return
	if not neighbor_initiated:
		return
	if chip_index in all_neighbors:
		flagged_container.append(get_parent().get_parent().board_occupation[chip_index])
		chip_management_node.get_node("chip_method").inverse_chip_method(board.board_occupation[chip_index],true)
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	for all_flagged in flagged_container:
		chip_management_node.get_node("chip_method").chip_method(all_flagged,true)
