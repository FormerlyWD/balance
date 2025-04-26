extends VSlider

@onready var base_offset
const SCROLL_MULT = 3



func _on_value_changed(value: float) -> void:
	
	%inventory.position.y = (-252.354+(value)*SCROLL_MULT)


func _on_drag_started() -> void:
	%shop_selector.deselect()
