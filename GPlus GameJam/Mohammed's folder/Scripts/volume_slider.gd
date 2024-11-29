extends HSlider

@export var busName: String
var busIndx: int

func _ready() -> void:
	busIndx = AudioServer.get_bus_index("MusicBus")
	value_changed.connect($"../../.."._on_Music_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndx))
	
	
func setVolume(val:float = db_to_linear(AudioServer.get_bus_volume_db(busIndx))) -> void:
	value = val
