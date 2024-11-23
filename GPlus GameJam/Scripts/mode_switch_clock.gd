extends TextureRect
@onready var texture_progress_bar = $TextureProgressBar
func _ready():
	Events.ModeChanged.connect(modechangedd)
	texture_progress_bar.max_value = Events.timer.wait_time
	set_process(false)
	
	
func _process(delta):
	texture_progress_bar.value = Events.timer.time_left


func modechangedd():
	set_process(true)
