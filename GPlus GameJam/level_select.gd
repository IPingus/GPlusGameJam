extends Control



func _on_tutorial_pressed():
	Utils.moveToScene("res://tutorial.tscn")


func _on_level_1_pressed():
	Utils.moveToScene("res://TileMap/tilemap.tscn")


func _on_level_2_pressed():
	Utils.moveToScene("res://Mohammed's folder/Scenes/Tilesets/level_2.tscn")



func _on_back_pressed():
	Utils.moveToScene("res://menu.tscn")
