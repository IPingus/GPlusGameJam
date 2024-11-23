extends Control


const LEVEL_1 = "res://Scenes/level_1.tscn"


func _on_play_pressed():
	Utils.moveToScene(LEVEL_1)


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
