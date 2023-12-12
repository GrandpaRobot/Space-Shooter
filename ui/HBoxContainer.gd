extends HBoxContainer

# TODO - Change this to not relative load?
@onready var ship = $"../../Ship" as PlayerShip

func _ready():
	var ability_buttons = get_children() as Array[AbilityButton]
	for index in ability_buttons.size():
		if(index > ship.abilities.size() - 1): return
		var ability = load("res://abilities/" + ship.abilities[index].name + ".tres") as AbilityData
		var ability_button = ability_buttons[index]
		# Needs a setter to set both button and texture cooldown
		ability_button.set('cooldown', ability.cooldown)
		ability_button.tooltip_text = ability.name
		ability_button.ability_name = ability.name
		ability_button.texture_normal = ability.icon
		
