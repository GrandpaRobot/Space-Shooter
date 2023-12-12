extends Control

@onready var container = $HBoxContainer

@export var abilities: Array[Ability]

func _ready():
	var ability_buttons = get_tree().get_nodes_in_group("AbilityButtonGroup")
	
	for index in abilities.size():
		var ability_button = ability_buttons[index]
		var ability = abilities[index]
		var ability_settings = ability.get_info() as AbilityComponent
		ability_button.ability = ability
		ability_button.tooltip_text = ability_settings.ability_name
		ability_button.texture_normal = ability_settings.image
		ability_button.set('cooldown', ability_settings.cooldown)
		ability_button.connect("cast", spell_cast)
		
func spell_cast(spell):
	var index = abilities.find(spell)
	abilities[index].cast()
