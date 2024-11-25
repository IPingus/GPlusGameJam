extends Node

signal add_screenshake(amount,duration)
signal ModeChanged()
signal enemydied()
@onready var timer = $Timer
@onready var state_chart = $StateChart

func _ready():
	ModeChanged.emit()

func _physics_process(delta):
	if Input.is_action_just_pressed("ModeChange") and timer.time_left ==0 :
		state_chart.send_event("ModeChange")
		timer.start(2)
	


func _on_future_state_entered():
	ModeChanged.emit()
	GlobalVars.mode = 2

func _on_past_state_entered():
	ModeChanged.emit()
	GlobalVars.mode = 1
