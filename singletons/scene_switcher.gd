extends Node

var _params = null

# Call this to be able to provide arguments to the next scene
func change_scene(next_scene, params=null):
	_params = params
	get_tree().change_scene_to_file(next_scene)

# Call this to get set parameters
func get_param(name):
	if _params != null and _params.has(name):
		return _params[name]
	return null
