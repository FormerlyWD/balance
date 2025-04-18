extends Node2D

@export var all_border_colors:Dictionary = {
	true: load("res://art_folder/chips/border/color1.png"),
	false: load("res://art_folder/chips/border/color2.png")
}
@export var all_rarity_colors:Dictionary = {
	"common": load("res://art_folder/chips/rarity colors/color1.png"),
	"uncommon": load("res://art_folder/chips/rarity colors/color2.png"),
	"rare": load("res://art_folder/chips/rarity colors/color3.png"),
	"extremely rare": load("res://art_folder/chips/rarity colors/color4.png")
}

func format(border_side:bool, rarity_color:String, logo:Texture) -> void:
	%"border color".texture = all_border_colors[border_side]
	%"rarity color".texture = all_rarity_colors[rarity_color]
	%logo.texture = logo
	$tweener.animate()
