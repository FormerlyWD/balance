
extends Node2D
@onready var is_in_deckview:bool = false
@onready var particle_buy_anim:PackedScene = preload("res://UI related stuff/buy_emit.tscn")
func _ready() -> void:
	info.current_scene = "Shop"
	%shop_spawn.summon_shop_squares()
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		if $shop_selector.is_selecting and not is_in_deckview: 
			
			if $shop_selector.selected_element.store_item_type == "Chip":
				if not info.all_currency.has($shop_selector.selected_element.buy_value_type):
					cant_purchase_anim($shop_selector.selected_element)
					return
				if info.all_currency[$shop_selector.selected_element.buy_value_type] < $shop_selector.selected_element.buy_value:
					cant_purchase_anim($shop_selector.selected_element)
					return
				%burstsound.play()
				info.all_currency[$shop_selector.selected_element.buy_value_type] -=  $shop_selector.selected_element.buy_value
				add_to_pos_draw_pile($shop_selector.selected_element.stored_chip)
				var new_particle_anim:CPUParticles2D = particle_buy_anim.instantiate()
				add_child(new_particle_anim)
				new_particle_anim.global_position = $shop_selector.selected_element.global_position
				new_particle_anim.emitting = true
				var element:Node2D = $shop_selector.selected_element
				element.queue_free()
			else:
				%burstsound.play()
				var new_particle_anim:CPUParticles2D = particle_buy_anim.instantiate()
				new_particle_anim.color = Color.html("ffffff")
				add_child(new_particle_anim)
				new_particle_anim.global_position = $shop_selector.selected_element.global_position
				new_particle_anim.emitting = true
				$shop_selector.selected_element.upon_selection()
				$dilemmas.queue_free()
				
				%shop_selector.deselect()
				
func add_to_pos_draw_pile(chip_name:String):
	
	info.positive_draw_pile.append(chip_name)
	var string_array:Array[String] = [chip_name]
	%inventory.create_chips(string_array)
	$shop_selector.deselect()


func cant_purchase_anim(shop_square: Node2D):
	if shop_square.is_animating_label:
		return
	%errorsound.play()
	shop_square.is_animating_label = true
	var price_label:Label = $shop_selector.selected_element.get_child(0).get_child(1)
	%shop_selector.cannot_do_animation()
	var new_tween:Tween = price_label.create_tween()
	var moving_range:int = 4  
	var time:float = 0.08
	var original_x:float = price_label.position.x 
	
	new_tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	
	for i in range(3):
		new_tween.tween_property(price_label, "position:x", original_x - moving_range, time)
		new_tween.tween_property(price_label, "position:x", original_x + moving_range, time)

	
	new_tween.tween_property(price_label, "position:x", original_x, time)

	await new_tween.finished
	shop_square.is_animating_label = false
	
	
