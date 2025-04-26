extends Node2D
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
	"Board selection is randomized for ",
	"value",
	" turns.",
	" Change board selection to select a new square."
]
var all_comps:Dictionary = {
	"value": 5
}
var one_shot:bool = true
var chip_spawne:Node2D
func chip_method(retrigger:bool = false)-> void:
	
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	info.headache_count += all_comps["value"]
	var chip_spawn:Node2D
	chip_spawne = get_parent().get_parent().get_parent().get_node("chip_management").get_node("chip_spawn")
	chip_spawne.remove_positive("Headache",false)
	if one_shot:
		var chip_spawner:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawner)
		one_shot = false
	
func chip_spawn(chip_vector:Vector2i):
	if info.headache_count>0:
		info.headache_count -=1
	else:
		return
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	info.headache_count = 0
