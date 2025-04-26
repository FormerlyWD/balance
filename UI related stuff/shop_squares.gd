extends Node2D

@onready var stored_chip:String
@onready var store_item_type:String = "Chip"
@onready var buy_value_type:String
@onready var buy_value:int
@onready var is_animating_label:bool
func _ready() -> void:
	$Area2D/Label.visible = false

func instantiate(possible_chips:Array[String]):
	get_parent().position_preview_chip(possible_chips,self)


func _on_area_2d_mouse_entered() -> void:
	select.emit_signal("shop_select", self)
	
func animate_down():
	$Area2D/Label.visible = false
	
func animate_up():
	$Area2D/Label.visible = true
