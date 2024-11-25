extends AudioStreamPlayer
@onready var audio_stream_player = $AudioStreamPlayer
@onready var state_chart = $StateChart


func _ready():
	Events.ModeChanged.connect(modechanged)
	modechanged()


func modechanged():
	state_chart.send_event("ModeChange")


func _on_past_state_entered():
	audio_stream_player.volume_db = -100000
	volume_db = 0


func _on_future_state_entered():
	audio_stream_player.volume_db = 0
	volume_db = -100000


func _on_finished():
	play()
