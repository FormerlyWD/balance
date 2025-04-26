extends Node2D


func chip_method(chip:Node2D, retrigger:bool = false):

	if chip.blocked_actions.has("disabled"):
		return
	if retrigger:
		if  chip.blocked_actions.has("retrigger"):
			return
		chip.chip_method(true)
	else:
		chip.chip_method(false)

func inverse_chip_method(chip:Node2D, retrigger:bool = false):
	
	if chip.blocked_actions.has("disabled"):
		return
	if retrigger:
		if  chip.blocked_actions.has("retrigger"):
			return
		chip.inverse_chip_method(true)
	else:
		chip.inverse_chip_method(false)
func buff(chip:Node2D, value:int):
	if chip.blocked_actions.has("disabled") or chip.blocked_actions.has("buff"):
		return
	chip.inverse_chip_method(false)
	chip.all_comps["value"] += value
	chip.chip_method(false)
func disable(chip:Node2D):
	chip.blocked_actions.append("disabled")
	chip.inverse_chip_method()
func enable(chip:Node2D):
	if chip.blocked_actions.has("disabled"):
		chip.blocked_actions.erase("disabled")
		chip.chip_method()

func check(chip:Node2D, retrigger:bool):
	if retrigger:
		if chip.blocked_actions.has("late_recall"):
			chip.blocked_actions.erase("late_recall")
		return false
	else:
		if chip.blocked_actions.has("late_recall"):
			return false
		return true
