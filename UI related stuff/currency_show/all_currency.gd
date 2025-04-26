extends Node2D
@onready var sample_currency_previewer:PackedScene = preload("res://UI related stuff/currency_show/currency_preview.tscn")
@onready var size:Vector2 = Vector2(32,16)
@export var offset:Vector2 = Vector2(
	
)
@export var x_cap:int = 3
@onready var all_previewers:Array[Node2D]
func get_currency_data():
	if all_previewers.size() > 0:
		for preview in all_previewers:
			all_previewers.erase(preview)
			preview.queue_free()
	var x_count:int = 0
	var y_count:int = 0
	for all_currencies in info.all_currency.keys():
		if x_count == x_cap:
			y_count +=1
			x_count = 0
		var new_previewer:Node2D = sample_currency_previewer.instantiate()
		all_previewers.append(new_previewer)
		add_child(new_previewer)
		new_previewer.position = Vector2(
			-offset.x+(x_count*size.x*new_previewer.scale.x*2)+(2*x_count),
			-offset.y+(y_count*size.y*new_previewer.scale.y*2)+(2*y_count)
		)
		x_count +=1
		new_previewer.format(all_currencies, info.all_currency[all_currencies])
func _ready() -> void:
	get_currency_data()
