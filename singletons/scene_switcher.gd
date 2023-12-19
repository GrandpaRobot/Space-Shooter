extends Node

var _params = null

# Call this to be able to provide arguments to the next scene
func change_scene(next_scene: PackedScene, params=null):
	_params = params
	get_tree().change_scene_to_packed(next_scene)

# Call this to get set parameters
func get_param(parameter_name: String):
	if _params != null and _params.has(parameter_name):
		return _params[parameter_name]
	return null
