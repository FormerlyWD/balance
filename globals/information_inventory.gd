extends Node

@onready var positive_draw_pile:Array[String] = [
	"Blank",
	"Blank",
	"Sleep"
]
@onready var negative_draw_pile:Array[String]
@onready var excess_morale:int
@onready var cash:int

@onready var all_chips:Array[Node] 
@onready var all_chip_names:Dictionary 
