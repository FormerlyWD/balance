extends Camera2D
func move_camera():
	%switchsound.play()
	var destined_point_x:float = 1080/2
	var new_tween:Tween = create_tween()
	new_tween.tween_property(self, "position:x", destined_point_x,0.25).set_trans(Tween.TRANS_BOUNCE)
	var new_descripter_tween:Tween = %descripter.create_tween()
	new_descripter_tween.tween_property(%descripter,"position:x",destined_point_x,0.25).set_trans(Tween.TRANS_BOUNCE)
	await new_tween.finished
	$"..".is_in_deckview = true
func move_camera_back():
	%switchsound.play()
	$"..".is_in_deckview = false
	var destined_point_x:float = 0
	var new_tween:Tween = create_tween()
	new_tween.tween_property(self, "position:x", destined_point_x,0.25).set_trans(Tween.TRANS_BOUNCE)
	var new_descripter_tween:Tween = %descripter.create_tween()
	new_descripter_tween.tween_property(%descripter,"position:x",-75,0.25).set_trans(Tween.TRANS_BOUNCE)
	
func move_camera_left():
	%switchsound.play()
	$"..".is_in_deckview = true
	var destined_point_x:float = -1080/2
	var new_tween:Tween = create_tween()
	new_tween.tween_property(self, "position:x", destined_point_x,0.25).set_trans(Tween.TRANS_BOUNCE)
	var new_descripter_tween:Tween = %descripter.create_tween()
	new_descripter_tween.tween_property(%descripter,"position:x",destined_point_x,0.25).set_trans(Tween.TRANS_BOUNCE)
