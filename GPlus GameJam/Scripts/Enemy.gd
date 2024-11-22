extends CharacterBody2D
class_name Enemy

@export var acceleration :float
@export var max_speed :float

@export var Fastacceleration = 150
@export var Fastmax_speed = 100

@export var Slowacceleration = 150
@export var Slowmax_speed = 30
@export var Armor: float

@export var player_path: NodePath

@onready var sprite_2d = $Sprite2D

@onready var stats = $Stats

@onready var label = $Label
var count = 0

func _ready():
	Events.ModeChanged.connect(ModeChanged)
	ModeChanged()
	label.text = str(stats.health)

func _physics_process(delta):
	if player_path is NodePath:
		var player = get_node(player_path)
		if player is CharacterBody2D:
			move_toward_postion(player.global_position, delta)

func move_toward_postion(target_position, delta):

	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(max_speed*direction,acceleration*delta)
	sprite_2d.flip_h = global_position < target_position
	
	move_and_slide()


func _on_stats_no_health():
	queue_free()

func _on_hurt_box_hurt(hitbox, damage,armorPierce):
	count+=1 
	
	stats.health = stats.health - max(0.1,(damage-(Armor*(1-armorPierce))))
	label.text = str(stats.health)


func ModeChanged():
	if GlobalVars.mode%2 == 0 and is_in_group("Past"):
		velocity = velocity*0.5
		max_speed = Slowmax_speed
		acceleration = Slowacceleration

	if GlobalVars.mode%2 == 1 and is_in_group("Past"):
		velocity = velocity*2
		max_speed = Fastmax_speed
		acceleration = Fastacceleration

	if GlobalVars.mode%2 == 0 and is_in_group("Future"):
		velocity = velocity*2
		max_speed = Fastmax_speed
		acceleration = Fastacceleration

	if GlobalVars.mode%2 == 1 and is_in_group("Future"):
		velocity = velocity*0.5
		max_speed = Slowmax_speed
		acceleration = Slowacceleration

