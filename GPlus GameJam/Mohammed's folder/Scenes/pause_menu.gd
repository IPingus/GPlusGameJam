extends Control

func _ready():
	hide()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1


func _on_unpause_pressed():
	hide()
	Engine.time_scale = 1

func _input(event):
	if Input.is_action_just_pressed("Puase"):
		if Engine.time_scale == 1:
			show()
			Engine.time_scale = 0
			
		else:
			hide()
			Engine.time_scale = 1


func _on_main_menu_pressed():
	Utils.moveToScene("res://menu.tscn")
