extends HBoxContainer
class_name AbilityBar

@export var ship: PlayerShip

func _ready():
	var ability_buttons = get_children() as Array[AbilityButton]
	for index in ability_buttons.size():
		if(index > ship.abilities.size() - 1): return
		# TODO - Is there a better way to do this? Seems fragile
		var ability = load("res://abilities/" + ship.abilities[index].name + '/' + ship.abilities[index].name + ".tres") as AbilityData
		var ability_button = ability_buttons[index]
		# Is a setter to set both ability and texture cooldown
		ability_button.set('cooldown', ability.cooldown)
		ability_button.tooltip_text = ability.name
		ability_button.ability = ability
		ability_button.texture_normal = ability.icon
		ability_button.set('change_key', str(index + 1))
