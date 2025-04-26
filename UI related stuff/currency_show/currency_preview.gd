extends Node2D

func format(currency_name:String, value:int):
	$name.text = currency_name
	$value.text = str(value)
