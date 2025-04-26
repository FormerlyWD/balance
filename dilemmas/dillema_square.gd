extends Node2D

@export var logo:Texture
@export var dilemma_name:String 
@export var description:String

@onready var store_item_type:String = "Dillema"
func _ready() -> void:
	$string_storer.d_name = dilemma_name
	$string_storer.description = description
	$name.text = dilemma_name
	$logo.texture = logo

	
	
func upon_selection():
	var base_chance:int = 30
	if info.all_currency.has("Experience"):
		base_chance +=  info.all_currency["Experience"]
	var rng = RandomNumberGenerator.new()
	var random_number:int = rng.randi_range(0,100)
	if random_number<base_chance:
		$"../..".add_to_pos_draw_pile("Accepted(job)")
		$"../..".add_to_pos_draw_pile("Investing")
		$"../..".add_to_pos_draw_pile("Work(job)")
		$"../..".add_to_pos_draw_pile("Work(job)")
	else:
		$"../..".add_to_pos_draw_pile("Rejected(job)")
