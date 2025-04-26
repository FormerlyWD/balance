extends Node

@onready var positive_draw_pile:Array[String] = [
	"Happiness",
	"Happiness",
	"Mental Expansion"
]
@onready var negative_draw_pile:Array[String] = [
	"Naive",
	"Naive"
]
@onready var all_currency:Dictionary = {
	"Morale":0,
	"Experience":0,
	"Cash":30
}

@onready var cash:int
@onready var resolution:Vector2 = Vector2(1920,450)
var current_scene:String = "Game" 
@onready var all_chips:Array[Node] 
var is_chip_listed:bool = false
var all_chip_names:Dictionary 
var all_chip_rarities:Dictionary

@export var all_border_colors:Dictionary = {
	true: load("res://art_folder/chips/border/color1.png"),
	false: load("res://art_folder/chips/border/color2.png")
}
@export var all_rarity_colors:Dictionary = {
	"common": load("res://art_folder/chips/rarity colors/color1.png"),
	"uncommon": load("res://art_folder/chips/rarity colors/color2.png"),
	"rare": load("res://art_folder/chips/rarity colors/color3.png"),
	"extremely rare": load("res://art_folder/chips/rarity colors/color4.png")
}
var rarities_and_rate:Dictionary = {
		"common":50,
		"uncommon":75,
		"rare":99,
		"extremely rare":100
	}
@onready var days:int = 0
@onready var specialized_days:int = 0
@onready var headache_count:int = 0
@onready var resetter_count:int = 0
@onready var trauma_count:int = 0
@onready var random_board_gen_modifier:Vector2i = Vector2i(
	1,1
)
@onready var morale_modifier:int = 1
@onready var refill_draw_pile:bool = false
@onready var sleep_active:bool = false
@onready var worse_blanks:bool = false
@onready var rng:RandomNumberGenerator = RandomNumberGenerator.new()
func _ready() -> void:
	randomize()
