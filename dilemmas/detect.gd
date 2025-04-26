extends Area2D



func _on_mouse_entered() -> void:
	select.emit_signal("shop_select", $"..")
