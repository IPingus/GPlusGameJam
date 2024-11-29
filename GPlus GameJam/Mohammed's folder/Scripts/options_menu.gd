extends Control

const MENU = "res://menu.tscn"
var busIndxMaster = AudioServer.get_bus_index("Master")
var busIndxMusic = AudioServer.get_bus_index("MusicBus")
var originalVolumeMaster: float
var originalVolumeMusic:float

func _ready() -> void:
	originalVolumeMaster = db_to_linear(AudioServer.get_bus_volume_db(busIndxMaster))
	originalVolumeMusic = db_to_linear(AudioServer.get_bus_volume_db(busIndxMusic))
func _on_main_menu_pressed() -> void:
	Utils.moveToScene(MENU)


func _on_sound_pressed() -> void:
	_on_Master_value_changed(originalVolumeMaster)
	$"MarginContainer/VBoxContainer/Master Volume".setVolume(originalVolumeMaster)
	_on_Music_value_changed(originalVolumeMusic)
	$"MarginContainer/VBoxContainer/Music Volume".setVolume(originalVolumeMusic)


func _on_Master_value_changed(value:float)->void:
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(busIndxMaster,linear_to_db(value))
func _on_Music_value_changed(value:float)->void:
	print(linear_to_db(value))
	AudioServer.set_bus_volume_db(busIndxMusic,linear_to_db(value))
