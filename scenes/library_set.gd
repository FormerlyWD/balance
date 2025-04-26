extends Node2D

func extract_one_library_set() -> Node2D:

	var rng = RandomNumberGenerator.new()
	var empty_array:Array[String] 
	var random_number:int = rng.randi_range(0,100)
	
	var chosen_rarity:String 
	for rarity_value in info.rarities_and_rate.values():
		if random_number <= rarity_value:
			chosen_rarity = info.rarities_and_rate.find_key(rarity_value)
			break
			
	var get_all_rarity:Dictionary = %chip_presets.get_all_chips_and_rarity()
	var rarity_oriented_array:Array = get_all_rarity[chosen_rarity]
	rarity_oriented_array.shuffle()
	return rarity_oriented_array[0]
	
	
func extract_negative_library_set(amount:int):
	var all_results:Array[String]
	for all_draws in amount:
			var rng = RandomNumberGenerator.new()
			var empty_array:Array[String] 
			var random_number:int = rng.randi_range(0,100)
			
			var chosen_rarity:String 
			for rarity_value in info.rarities_and_rate.values():
				if random_number <= rarity_value:
					chosen_rarity = info.rarities_and_rate.find_key(rarity_value)
					break
					
			var get_all_rarity:Dictionary = %chip_presets.get_all_chips_and_rarity_neg()
			var rarity_oriented_array:Array = get_all_rarity[chosen_rarity]
			rarity_oriented_array.shuffle()
			info.negative_draw_pile.append(rarity_oriented_array[0].name) 
	
