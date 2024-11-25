extends CharacterBody2D
class_name Enemy

var insideEnemy = false
var ramd=randf_range(-4,4)
@export var acceleration :float
@export var max_speed :float
@export var Fastacceleration = 150
@export var Fastmax_speed = 100
@export var Slowacceleration = 150
@export var Slowmax_speed = 30
@export var fastFireRate=.7
@export var SlowFireRate=2
@export var Armor: float
@export var player_path: NodePath
@onready var sprite_2d = $Sprite2D
@onready var stats = $Stats
@onready var audio_stream_player = $AudioStreamPlayer
var animationName = "RESET"
var damage = 2
var armorPierce =0
@export var fireRate = 1
@export var BULLETS : PackedScene
@export var playerNode : CharacterBody2D
var count = 0
@export var animation_player:AnimationPlayer
var moving = true
@onready var timer = $Timer
@onready var nav_agent = $NavigationAgent2D
var active = false : set = activated
@onready var Timeline = $StateChart

@onready var canvas_layer = $Sprite2D/CanvasLayer


func _ready():
	Events.ModeChanged.connect(ModeChanged)
	ModeChanged()
		

func activated(value):
	if value:
		active=true
		Timeline.send_event("Activated")
		timer.start()
		

func _physics_process(delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	#velocity = dir*max_speed
	move_toward_postion(dir, delta)
	#move_and_slide()
	#if player_path is NodePath and player_path:
		#animation_player.play(animationName)
		#var player = get_node(player_path)
		#

func makepath():
	nav_agent.target_position = playerNode.global_position
	
func move_toward_postion(direction, delta):
	if moving:
		#var direction = global_position.direction_to(target_position)
		velocity = velocity.move_toward(max_speed*direction,acceleration*delta)
		sprite_2d.flip_h = global_position < direction
		if insideEnemy: #and timer.is_stopped():
			velocity=velocity+Vector2(ramd,ramd)
	move_and_slide()


func _on_stats_no_health():
	Events.enemydied.emit()
	queue_free()

func _on_hurt_box_hurt(hitbox, damage,armorPierce):
	stats.health = stats.health - max(0.1,(damage-(Armor*(1-armorPierce))))
	audio_stream_player.play()


func ModeChanged():
	Timeline.send_event("ModeChange")



func _on_area_2d_area_entered(area):
	insideEnemy = true
	velocity=velocity+Vector2(ramd,ramd)
	


func _on_area_2d_area_exited(area):
	insideEnemy = false
	


func _on_past_state_entered():
	if is_in_group("Past"):
		Timeline.send_event("CorrectTime")
	else:
		Timeline.send_event("WrongTime")


func _on_future_state_entered():
	if is_in_group("Future"):
		Timeline.send_event("CorrectTime")
	else:
		Timeline.send_event("WrongTime")


func _on_normal_state_entered():
	#canvas_layer.hide()
	animationName = "SlowWalk"
	animation_player.play(animationName)
	velocity = velocity*0.5
	max_speed = Slowmax_speed
	acceleration = Slowacceleration
	fireRate = 1


func _on_enraged_state_entered():
	#canvas_layer.show()
	animationName = "Walk"
	animation_player.play(animationName)
	velocity = velocity*2
	max_speed = Fastmax_speed
	acceleration = Fastacceleration
	fireRate = 0.5


func _on_timer_timeout():
	makepath()


func _on_not_active_state_entered():
	animation_player.stop()
	Timeline.send_event("Activated")
