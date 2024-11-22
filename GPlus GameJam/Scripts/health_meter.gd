extends Control
@onready var full = $Full

func _ready():
	PlayerStats.health_changed.connect(updateHealthUI)
	updateHealthUI()
func updateHealthUI():
	full.size.x = PlayerStats.health*5+1
