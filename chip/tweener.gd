extends Node2D


func _ready() -> void:
	pass
	
func animate():
	var new_tween = get_tree().create_tween()
	new_tween.tween_property($"..","scale",Vector2.ONE*1,0.3).set_trans(Tween.TRANS_BOUNCE)
