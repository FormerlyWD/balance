
extends Node2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		%shop_spawn.summon_shop_squares()
