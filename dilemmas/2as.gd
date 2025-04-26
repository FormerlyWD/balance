extends Node2D
@export var logo:Texture
@export var dilemma_name:String 
@export var description:String
@export var dillema_script:Script
@onready var store_item_type:String = "Dillema"
func _ready() -> void:
	$string_storer.d_name = dilemma_name
	$string_storer.description = description
	$name.text = dilemma_name
	$logo.texture = logo
	

	
	
func upon_selection():
	info.morale_modifier += 3
	info.random_board_gen_modifier *= 2
