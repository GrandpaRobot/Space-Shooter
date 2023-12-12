extends Node
class_name Ability

@export var ability_data: AbilityData

func cast():
	print('ability', ability_data.name)
