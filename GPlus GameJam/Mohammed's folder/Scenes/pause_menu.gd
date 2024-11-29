extends Control


const LEVEL_1 = "res://tilemap/tilemap.tscn"



func _on_restart_pressed() -> void:
	Utils.moveToScene(LEVEL_1)
