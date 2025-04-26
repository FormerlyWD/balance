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
	name = dilemma_name
	set_script(dillema_script)
	
func upon_selection():
	pass
