extends Control
@onready var full = $Full
@onready var empty = $Empty

func _ready():
	PlayerStats.health_changed.connect(updateHealthUI)
	updateHealthUI()
	empty.size.x = PlayerStats.max_health*5+1
func updateHealthUI():
	full.size.x = PlayerStats.health*5+1
