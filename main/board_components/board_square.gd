extends Node2D

func _ready() -> void:
	var new_tween:Tween = create_tween()
	new_tween.tween_property(self,"scale",Vector2.ONE*2,2).set_trans(Tween.TRANS_SINE)
	
	$square_sprite/emit.emitting = true
	


func _on_emit_finished() -> void:
	signalst.emit_signal("shake_camera",0.6)
	$square_sprite/earth_sound.play()
