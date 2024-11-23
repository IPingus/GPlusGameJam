extends Node

func instanceSceneOnMain(scene: PackedScene, position: Vector2):
	var main = get_tree().current_scene
	var instance = scene.instantiate()
	main.add_child(instance)
	instance.global_position = position
	return instance
func moveToScene(scene: String):
	get_tree().change_scene_to_file(scene)
