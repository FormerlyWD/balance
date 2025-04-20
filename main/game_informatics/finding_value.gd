extends Node


func end_day_status():
	pass
	print("thats wild")
	var calculated_value:int=  int(%pos_counter.text) - int(%neg_counter.text) 
	if calculated_value>=0:
		info.excess_morale = calculated_value
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
		
		
