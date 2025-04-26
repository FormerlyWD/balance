extends Node2D
@export_category("essentials")
@export var rarity:String = "common"
@onready var chip_name:String = name
@export var chip_overide:bool = false

@onready var logo:Texture = $logo.texture

@export_category("cans and dos")
@export var blocked_actions:Array[String] = [
	
]
@export var buff_value:int
@onready var afterinstance_blocked_actions:Array[String]
@export_category("buying")
@export_enum( "Morale", "Cash")
var buy_value_type:String = "Morale"
@export var buy_value:int
var description_structure:Array[String] = [
	"-",
	"30",
	" Cash.",
	" Gain",
	" 1/",
	"value",
	" Cash back.",
	" Buffing this card is counterintuitive."
]
var all_comps:Dictionary = {
	"value": 3
}
var one_shot:bool = true
var investment_value:float = 0

func chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("action retrigger"):
		if retrigger: return
	investment_value += 1/all_comps["value"]*info.all_currency["Cash"]
	info.all_currency["Cash"] -= 30
	
	if one_shot:
		var chip_spawner:Callable = Callable(self, "chip_spawn")
		signalst.connect("chip_spawn", chip_spawner)
		one_shot = false
func chip_spawn(chip:Vector2i):
	info.all_currency["Cash"] += investment_value
	
func inverse_chip_method(retrigger:bool = false)-> void:
	if blocked_actions.has("retrigger") or blocked_actions.has("late_recall")  or blocked_actions.has("inverse action retrigger") :
		if retrigger: return
	info.all_currency["Cash"] += 30
	investment_value = 0
