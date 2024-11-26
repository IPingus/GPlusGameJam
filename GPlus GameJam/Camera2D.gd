extends Camera2D
@onready var timer = $Timer
@onready var state_chart = $StateChart
@onready var canvas_layer = $CanvasLayer

var shake = 0

func _ready():
	Events.add_screenshake.connect(start_screenchake)
	Events.ModeChanged.connect(ModeChanged)

func _process(delta):
	offset.x = randf_range(-shake,shake)
	offset.y = randf_range(-shake,shake)

func start_screenchake(amount,duration):
	shake = amount
	timer.start(duration)

func ModeChanged():
	state_chart.send_event("mode Changed")
	


func _on_timer_timeout():
	shake = 0


func _on_normal_state_entered():
	canvas_layer.hide()


func _on_glitched_state_entered():
	canvas_layer.show()
