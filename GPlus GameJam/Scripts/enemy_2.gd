extends CharacterBody2D
@onready var ray_cast_2d = $RayCast2D
@export var player:CharacterBody2D
@onready var sprite_2d = $Sprite2D
@onready var state_chart = $StateChart

func _ready():
	Events.ModeChanged.connect(modeChanged)
	modeChanged()
func _process(delta):
	ray_cast_2d.target_position = to_local(player.position)
	#if ray_cast_2d.get_collider().is_in_group("Player"):
	

func modeChanged():
	if GlobalVars.mode == 1:# and is_in_group("Past"):
		sprite_2d.modulate = Color("Blue")
		state_chart.send_event("WrongTime")
		
		#animationName = "SlowWalk"
		#velocity = velocity*0.5
		#max_speed = Slowmax_speed
		#acceleration = Slowacceleration

	if GlobalVars.mode ==2:# and is_in_group("Past"):
		sprite_2d.modulate = Color("RED")
		state_chart.send_event("WrongTime")
		#animationName = "Walk"
		#velocity = velocity*2
		#max_speed = Fastmax_speed
		#acceleration = Fastacceleration

	#if GlobalVars.mode%2 == 1 and is_in_group("Future"):
		#animationName = "Walk"
		#velocity = velocity*2
		#max_speed = Fastmax_speed
		#acceleration = Fastacceleration
#
	#if GlobalVars.mode%2 == 0 and is_in_group("Future"):
	#
