extends Control


const tutorial = "res://tutorial.tscn"
const OPTIONS_MENU = "res://Mohammed's folder/Scenes/options_menu.tscn"

func _on_play_pressed():
	Utils.moveToScene(tutorial)


func _on_options_pressed():
	Utils.moveToScene(OPTIONS_MENU)


func _on_quit_pressed():
	get_tree().quit()


func _on_level_select_pressed():
	Utils.moveToScene("res://level_select.tscn")
