extends Node2D
@onready var chip_overide:bool = false
@onready var rarity:String = "rare"
@onready var logo:Texture = $logo.texture
@onready var all_neighbors:Array[Vector2i]
@onready var neighbor_initiated:bool = false
func chip_method():
	var morale_container:int = 1
	var board:Node2D = get_parent().get_parent()
	var index:Vector2i = board.board_occupation.find_key(self)
	all_neighbors = [
		Vector2i(1,0)+index,
		Vector2i(-1,0)+index,
		Vector2i(1,1)+index,
		Vector2i(0,1)+index,
		Vector2i(-1,1)+index,
		Vector2i(0,-1)+index,
		Vector2i(1,-1)+index,
		Vector2i(-1,-1)+index
		
	]
	neighbor_initiated = true
	for neighbor in all_neighbors:
		if neighbor in board.board_occupation.keys():
			signalst.emit_signal("morale_addition",1)
	var chip_spawn:Callable = Callable(self, "chip_spawn")
	signalst.connect("chip_spawn", chip_spawn)

func chip_spawn(chip_index:Vector2i):
	print("UBI")
	if not neighbor_initiated:
		return
	if chip_index in all_neighbors:
		signalst.emit_signal("morale_addition",1)
func inverse_chip_method():
	signalst.emit_signal("morale_subtraction",1)
