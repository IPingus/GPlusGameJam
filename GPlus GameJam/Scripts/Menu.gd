extends Control


#const LEVEL_1 = "res://tilemap/tilemap.tscn"
const LEVEL_2 = "res://Mohammed's folder/Scenes/tilemap_placeholder_mohammed.tscn"

func _on_play_pressed():
	Utils.moveToScene(LEVEL_2)


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
