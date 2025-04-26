extends Sprite2D
@onready var removal_queue:Array[String]
func _ready() -> void:
	var morale_addition:Callable = Callable(self, "morale_addition")
	signalst.connect("morale_addition", morale_addition)
	var morale_subtraction:Callable = Callable(self, "morale_subtraction")
	signalst.connect("morale_subtraction", morale_subtraction)
	var remove_container:Callable = Callable(self, "remove_container")
	signalst.connect("remove_container", remove_container)
func morale_addition(addition:float, chip_name:String):
	addition *= info.morale_modifier
	if removal_queue.has(chip_name):
		print("")
		removal_queue.erase(chip_name)
		return
	if not %balance.morale_container.has(chip_name):
		%balance.morale_container[chip_name] = Vector2i(0,0)
	if 0>addition:
		%balance.morale_container[chip_name] += Vector2i(0,-addition)
		%neg_counter.text = str(int(%neg_counter.text) + -addition)
	else:
		%balance.morale_container[chip_name] += Vector2i(addition,0)
		%pos_counter.text = str(int(%pos_counter.text) + addition)
func morale_subtraction(subtraction:float, chip_name:String):
	if removal_queue.has(chip_name):
		removal_queue.erase(chip_name)
		return
	if not %balance.morale_container.has(chip_name):

		%balance.morale_container[chip_name] = Vector2i(0,0)
	if 0>subtraction:
		%balance.morale_container[chip_name] -= Vector2i(0,-subtraction)
		%neg_counter.text = str(int(%neg_counter.text) - -subtraction)
	else:
		%balance.morale_container[chip_name] -= Vector2i(subtraction,0)
		%pos_counter.text = str(int(%pos_counter.text) - subtraction)
func remove_container(chip_name:String):
	
	if %balance.morale_container.has(chip_name):
		if %balance.morale_container[chip_name].x > 0:
			%pos_counter.text = str(int(%pos_counter.text) - %balance.morale_container[chip_name].x)
		if %balance.morale_container[chip_name].y > 0:
			%neg_counter.text = str(int(%neg_counter.text) - %balance.morale_container[chip_name].y)
	else:
		removal_queue.append(chip_name)
