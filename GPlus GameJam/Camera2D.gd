extends Camera2D
@onready var timer = $Timer

var shake = 0

func _ready():
	Events.add_screenshake.connect(start_screenchake)

func _process(delta):
	offset.x = randf_range(-shake,shake)
	offset.y = randf_range(-shake,shake)

func start_screenchake(amount,duration):
	shake = amount
	timer.start(duration)
	


func _on_timer_timeout():
	shake = 0
