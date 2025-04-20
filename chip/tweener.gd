extends Node2D


func _ready() -> void:
	pass
	
func animate():
	var tree = self.get_tree()
	var new_tween = self.get_tree().create_tween()
	
	new_tween.tween_property($"..","scale",Vector2.ONE*1,0.3).set_trans(Tween.TRANS_BOUNCE)
