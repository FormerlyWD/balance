extends Node2D


func _ready() -> void:
	pass
	
func animate():
	var new_tween = self.create_tween()
	
	new_tween.tween_property($"..","scale",Vector2.ONE*1,0.3).set_trans(Tween.TRANS_BOUNCE)
	if info.current_scene == "Game":
		var board:Node2D = get_parent().get_parent().get_parent().get_parent().get_node("board")
		var main:Node2D = get_parent().get_parent().get_parent().get_parent()
		var board_num:int = board.board_squares.size()
		var board_occ:int = board.board_occupation.size()+1
		var end_turn_bool:bool = false
		if board_num == board_occ:
			end_turn_bool = true
		else:
			print("========")
			print(board_num)
			print(board_occ)
			print("========")
		await new_tween.finished
		if  end_turn_bool:
			
			main.get_node("balance").end_day_status()
	
