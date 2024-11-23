extends AudioStreamPlayer
@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	modechanged()
	Events.ModeChanged.connect(modechanged)
	
	
func modechanged():
	if GlobalVars.mode%2==0:
		audio_stream_player.volume_db = 0
		volume_db = -100000
	elif GlobalVars.mode%2==1:
		audio_stream_player.volume_db = -100000
		volume_db = 0
	
