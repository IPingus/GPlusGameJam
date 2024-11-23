extends CharacterBody2D
class_name Player

@export var SPEED = 80.0
@export var ACCEL = 150
#@onready var animated_sprite_2d = $AnimatedSprite2D
var input: Vector2
var weapon:Weapon


@onready var fire_rate_timer = $FireRateTimer
@onready var mode_change_cooldown = $ModeChangeCooldown
@onready var hurtbox = $Hurtbox
@onready var blinking = $Blinking
@onready var smg = $SMG
@onready var crossbow = $Crossbow


@onready var healt = $Healt
@onready var sprite_2d_2 = $Sprite2D2
@onready var mode_switch = $modeSwitch
@onready var animation_player = $AnimationPlayer


signal ModeChangedSig()

func _ready():
	PlayerStats.no_health.connect(die)
	Events.ModeChanged.connect(ModeChanged)
	ModeChanged()
	healt.text = str(PlayerStats.health)

func	get_input():
	input.x = Input.get_action_raw_strength("Right") -  Input.get_action_raw_strength("Left")
	input.y = Input.get_action_raw_strength("Down") -  Input.get_action_raw_strength("Up")
	return input.normalized()
	


func _process(delta):
	
#	if (velocity.x != 0 || velocity.y != 0 ):
#		animated_sprite_2d.animation = "move"
#	else:
#		animated_sprite_2d.animation = "idle"

	if get_local_mouse_position().angle()<-1.8 or get_local_mouse_position().angle()>1.2:
		sprite_2d_2.flip_h = false
		weapon.sprite_2d.flip_v=true
	else:
		sprite_2d_2.flip_h = true
		weapon.sprite_2d.flip_v=false
	
	var playerInput = get_input()
	
	
	velocity = lerp(velocity, playerInput*SPEED, delta*ACCEL)
	animation_player.play("walk")
	
	move_and_slide()
	
func _physics_process(delta):
	if Input.is_action_pressed("Shoot") and fire_rate_timer.is_stopped() and mode_switch.time_left==0:
		weapon.fireBullet()
		fire_rate_timer.start(weapon.fireRate)
		
func ModeChanged():
	GlobalVars.mode+=1
	mode_switch.start()
	fire_rate_timer.stop()
	ModeChangedSig.emit()
	if GlobalVars.mode%2 == 0:
		crossbow.hide()
		smg.visible = true
		weapon = smg

	if GlobalVars.mode%2 == 1:
		smg.hide()
		crossbow.visible = true
		weapon = crossbow

func _on_hurtbox_hurt(hitbox, damage,armorPierce):
	Events.add_screenshake.emit(1,0.25)
	PlayerStats.health-= damage
	healt.text = str(PlayerStats.health)
	blinking.play("blink")



func die():
	queue_free()
