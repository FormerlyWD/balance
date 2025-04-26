extends Node
@onready var morale_container:Dictionary = {
	
} 
@onready var excess_morale:int 
func end_day_status():
	$recheck.start()
	return
	pass
	var calculated_value:int=  int(%pos_counter.text) - int(%neg_counter.text) 
	
	if info.specialized_days>=0:
		info.specialized_days -=1
	else:
		info.days +=1
		%library_set.extract_negative_library_set(info.days)
	excess_morale = calculated_value
	if calculated_value>0:
		if not info.all_currency.has("Morale"):
			info.all_currency["Morale"] = 0
		info.all_currency["Morale"] += calculated_value
		$Timer.start()
		#info.current_scene = "Shop"
		#get_tree().change_scene_to_file("res://scenes/shop.tscn")
	elif calculated_value == 0:
		info.current_scene = "Shop"
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
		


func _on_timer_timeout() -> void:
	%pos_counter.text = str(int(%pos_counter.text)-1)
	if excess_morale == 0:
		info.current_scene = "Shop"
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
		$Timer.stop()
	excess_morale -= 1


func _on_recheck_timeout() -> void:
	$recheck.stop()
	
	if %board.board_squares.size() == %board.board_occupation.size() or info.sleep_active:
		pass
		if info.resetter_count ==0:
			info.sleep_active = false
			info.refill_draw_pile = false
			info.worse_blanks = false
			info.random_board_gen_modifier = Vector2.ONE
			info.morale_modifier = 1
		else:
			info.resetter_count -=1
		
		var calculated_value:int=  int(%pos_counter.text) - int(%neg_counter.text) 
		
		if info.specialized_days>0:
			info.specialized_days -=1
		else:
			info.days +=1
			%library_set.extract_negative_library_set(info.days+2)
		excess_morale = calculated_value
		if calculated_value>0:
			if not info.all_currency.has("Morale"):
				info.all_currency["Morale"] = 0
			info.all_currency["Morale"] += calculated_value
			$Timer.start()
			#info.current_scene = "Shop"
			#get_tree().change_scene_to_file("res://scenes/shop.tscn")
		elif calculated_value == 0:
			info.current_scene = "Shop"
			get_tree().change_scene_to_file("res://scenes/shop.tscn")
