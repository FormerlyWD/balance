extends Node2D



func format(border_side:bool, rarity_color:String, logo:Texture,tween_disable:bool = false) -> void:
	%"border color".texture = info.all_border_colors[border_side]
	%"rarity color".texture = info.all_rarity_colors[rarity_color]
	%logo.texture = logo
	if not tween_disable:
		$tweener.animate()
	else:
		scale = Vector2.ONE*2
