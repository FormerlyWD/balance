extends Area2D


@onready var is_entered:bool = false

func _on_mouse_entered() -> void:
	%shop_selector.deselect()
	is_entered =true
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		if is_entered:
			get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_mouse_exited() -> void:
	is_entered =false
