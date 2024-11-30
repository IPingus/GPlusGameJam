extends Control

func _ready():
	hide()


func _on_restart_pressed() -> void:
	Engine.time_scale = 1
	PlayerStats.health=PlayerStats.max_health
	get_tree().reload_current_scene()
	
	


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
	Engine.time_scale = 1
	PlayerStats.health=PlayerStats.max_health
	Utils.moveToScene("res://menu.tscn")
