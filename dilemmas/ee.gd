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
	for i in range(3):
		$"../..".add_to_pos_draw_pile("Work(project)")
