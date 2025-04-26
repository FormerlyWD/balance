extends Node2D

@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture


@onready var all_neighbors:Array[Vector2i]
@onready var neighbor_initiated:bool = false
@export_category("cans and dos")
@export var blocked_actions:Array[String]
@export var buff_value:int
@export_category("buying")
@export_enum( "Morale", "Cash", "Experience")
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
@onready var morale_container:int = 0
var one_shot:bool = true
@onready var chip_unique_name:String 
func chip_method(retrigger:bool = false):
	var board:Node2D = get_parent().get_parent()
	if one_shot:
		chip_unique_name = name + str(board.board_occupation.keys().size())
		one_shot = false
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
			morale_container += all_comps["value"]
			signalst.emit_signal("morale_addition",all_comps["value"], chip_unique_name)
	if one_shot:
		var chip_spawn:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawn)
		one_shot = false
	var chip_spawn:Node2D
	chip_spawn = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	chip_spawn.remove_positive("Study",false)
func chip_spawn(chip_index:Vector2i):
	if blocked_actions.has("disabled"):
		return
	if not neighbor_initiated:
		return
	if chip_index in all_neighbors:
		morale_container += all_comps["value"]
		signalst.emit_signal("morale_addition",all_comps["value"],chip_unique_name)
func inverse_chip_method(retrigger:bool = false):
	print("FGF")
	signalst.emit_signal("remove_container",chip_unique_name)
