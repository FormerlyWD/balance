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
	"if this stays in the board for ",
	"value",
	" turns, add a Depression into your draw pile"
]
var all_comps:Dictionary = {
	"value": 5
}
var trauma_count:int = 0
var done:bool = false
var one_shot:bool = true
@onready var chip_unique_name:String
func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
		
	done = false
	trauma_count += all_comps["value"]
	if one_shot:
		var chip_spawner:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawner)
		one_shot = false
	
func chip_spawn(chip_vector:Vector2i):
	print()
	if done:
		return
	var chip_spawn:Node2D = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	if trauma_count<=0:
		
		print("shiny")
		done = true
		chip_spawn.add_negative("Depression",true)
		return
	else:
		trauma_count -=1
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	done = true
