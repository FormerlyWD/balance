extends Node

signal camera_change(zoom_level:float)
signal morale_addition(addition_value:float)
signal remove_container(chip_name:String)
signal morale_subtraction(subtraction_value:float)
signal reorder_dimention
signal chip_spawn(chip_index:Vector2i)
signal chip_removed(chip_index)
signal new_turn
signal dimention_update(dimention:Vector2i,dimention_addition:Vector2i)
signal shake_camera(trauma_addition:float)
