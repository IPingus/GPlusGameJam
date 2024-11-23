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
@onready var label = $Label
@onready var audio_stream_player = $AudioStreamPlayer

var damage = 2
var armorPierce =0
@export var BULLETS : PackedScene
@export var playerss : Player
var count = 0

func _ready():
	Events.ModeChanged.connect(ModeChanged)
	ModeChanged()
	label.text = str(stats.health)


func _physics_process(delta):

	if player_path is NodePath and player_path:
		var player = get_node(player_path)
		if player is CharacterBody2D:
			move_toward_postion(player.global_position, delta)


func move_toward_postion(target_position, delta):

	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(max_speed*direction,acceleration*delta)
	sprite_2d.flip_h = global_position < target_position
	if insideEnemy: #and timer.is_stopped():
		velocity=velocity+Vector2(ramd,ramd)
	move_and_slide()


func _on_stats_no_health():
	Events.enemydied.emit()
	queue_free()

func _on_hurt_box_hurt(hitbox, damage,armorPierce):
	count+=1 
	
	stats.health = stats.health - max(0.1,(damage-(Armor*(1-armorPierce))))
	audio_stream_player.play()
	label.text = str(stats.health)


func ModeChanged():
	if GlobalVars.mode%2 == 1 and is_in_group("Past"):
		velocity = velocity*0.5
		max_speed = Slowmax_speed
		acceleration = Slowacceleration

	if GlobalVars.mode%2 == 0 and is_in_group("Past"):
		velocity = velocity*2
		max_speed = Fastmax_speed
		acceleration = Fastacceleration

	if GlobalVars.mode%2 == 1 and is_in_group("Future"):
		velocity = velocity*2
		max_speed = Fastmax_speed
		acceleration = Fastacceleration

	if GlobalVars.mode%2 == 0 and is_in_group("Future"):
		velocity = velocity*0.5
		max_speed = Slowmax_speed
		acceleration = Slowacceleration



func _on_area_2d_area_entered(area):
	insideEnemy = true
	velocity=velocity+Vector2(ramd,ramd)
	


func _on_area_2d_area_exited(area):
	insideEnemy = false
	


