extends Sprite2D
func _ready() -> void:
	var morale_addition:Callable = Callable(self, "morale_addition")
	signalst.connect("morale_addition", morale_addition)
	var morale_subtraction:Callable = Callable(self, "morale_subtraction")
	signalst.connect("morale_subtraction", morale_subtraction)
func morale_addition(addition:float):
	if 0>addition:
		%neg_counter.text = str(int(%neg_counter.text) + -addition)
	else:
		%pos_counter.text = str(int(%pos_counter.text) + addition)
func morale_subtraction(subtraction:float):
	if 0>subtraction:
		%neg_counter.text = str(int(%neg_counter.text) - -subtraction)
	else:
		%pos_counter.text = str(int(%pos_counter.text) - subtraction)
