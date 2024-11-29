extends Control


const LEVEL_1 = "res://tilemap/tilemap.tscn"
const OPTIONS_MENU = "res://Mohammed's folder/Scenes/options_menu.tscn"

func _on_play_pressed():
	Utils.moveToScene(LEVEL_1)


func _on_options_pressed():
	Utils.moveToScene(OPTIONS_MENU)


func _on_quit_pressed():
	get_tree().quit()
