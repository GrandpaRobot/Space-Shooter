class_name Ability
extends Node

var ability_name = "":
	set(value):
		ability_name = value
	
func cast():
	print('hello', ability_name)
