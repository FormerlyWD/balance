extends Node2D


func _ready() -> void:
	pass

func instantiate(possible_chips:Array[String]):
	get_parent().position_preview_chip(possible_chips,self)
