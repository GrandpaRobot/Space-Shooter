# Give the component a class name so it can be instanced as a custom node
class_name SpawnerComponent
extends Node2D

# Export the dependencies for this component
# The scene we want to spawn
@export var scene: PackedScene

# Spawn an instance of the scene at a specific global position on a parent
# By default the parent is the current "main" scene , but you can pass in
# an alternative parent if you so choose.
func spawn(global_pos: Vector2 = global_position, parent: Node = get_tree().current_scene, custom_velocity = Vector2(0,0)) -> Node:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner component.")
	# Instance the scene
	var instance = scene.instantiate()

	# Check if a custom velocity is provided and apply it
	if custom_velocity != Vector2(0,0):
		instance.velocity = custom_velocity

	# Add it as a child of the parent
	parent.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	instance.global_position = global_pos

	# Return the instance in case we want to perform any other operations
	# on it after instancing it.
	return instance
