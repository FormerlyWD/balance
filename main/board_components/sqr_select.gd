extends Area2D





func _on_mouse_entered() -> void:
	select.emit_signal("selected_block", $"..")


func _on_mouse_exited() -> void:
	select.emit_signal("unselected_block")
