extends Node

signal add_screenshake(amount,duration)
signal ModeChanged()
@onready var timer = $Timer


func _physics_process(delta):
	if Input.is_action_just_pressed("ModeChange") and timer.time_left ==0 :
		ModeChanged.emit()
