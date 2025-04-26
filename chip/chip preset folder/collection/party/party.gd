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

@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"retriggers all row-neighboring chips ",
	"value",
	" time(s)"
	
]
var all_comps:Dictionary = {
	"value": 1
}
var all_rowing_neighbors:Array[Vector2i] = [
	
]
@onready var chip_management_node:Node
var index:Vector2i
var one_shot:bool = true
@onready var board:Node2D 
func chip_method(retrigger:bool = false)-> void:
	board = get_parent().get_parent()
	chip_management_node = get_parent().get_parent().get_parent().get_node("chip_management")
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	print(blocked_actions)
	var index:Vector2i = board.board_occupation.find_key(self)
	for all_rows in range(board.dimentions.x-1):
		all_rowing_neighbors.append(Vector2i(
			all_rows,
			index.y
		))
	all_rowing_neighbors.erase(index)
	for indexes in all_rowing_neighbors:
		if board.board_occupation.has(indexes):
			chip_management_node.get_node("chip_method").chip_method(board.board_occupation[indexes],true)
	if one_shot:
		var dimention_update:Callable = Callable(self, "dimention_update")
		signalst.connect("dimention_update", dimention_update)
		one_shot = false
		var chip_spawn:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawn)
		one_shot = false

func chip_spawn(chip_index:Vector2i):
	if blocked_actions.has("disabled"):
		return
	if chip_index in all_rowing_neighbors:

		chip_management_node.get_node("chip_method").chip_method(board.board_occupation[chip_index],true)
func dimention_update(new_dimention:Vector2i, dimention_addition:Vector2i):

	if dimention_addition.x> 0:
		var old_dimention = new_dimention-dimention_addition
		var new_container:Array[Vector2i]
		for new_rows in range(dimention_addition.x-1):
			new_container.append( Vector2i(
				index.y,
				old_dimention.x+new_rows
			)
			)
			all_rowing_neighbors += new_container
			
			
		old_dimention.x-1
func inverse_chip_method(retrigger:bool = false)-> void:


	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	for indexes in all_rowing_neighbors:
		if board.board_occupation.has(indexes):
			chip_management_node.get_node("chip_method").inverse_chip_method(board.board_occupation[indexes],true)
		
