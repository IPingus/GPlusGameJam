extends CharacterBody2D
class_name Player

var health = 3
const SPEED = 300.0
const ACCEL = 150
#@onready var animated_sprite_2d = $AnimatedSprite2D
var input: Vector2
var weaponT:int

@onready var fire_rate_timer = $FireRateTimer
@onready var mode_change_cooldown = $ModeChangeCooldown
@onready var label = $Label
@onready var hurtbox = $Hurtbox
@onready var blinking = $Blinking
@onready var smg = $SMG
@onready var weapon = $Weapon




func _ready():
	PlayerStats.no_health.connect(die)
	if GlobalVars.mode%2 == 0:
		weapon.hide()
		smg.visible = true

	if GlobalVars.mode%2 == 1:
		smg.hide()
		weapon.visible = true

func	get_input():
	input.x = Input.get_action_raw_strength("Right") -  Input.get_action_raw_strength("Left")
	input.y = Input.get_action_raw_strength("Down") -  Input.get_action_raw_strength("Up")
	return input.normalized()
	


func _process(delta):
	
#	if (velocity.x != 0 || velocity.y != 0 ):
#		animated_sprite_2d.animation = "move"
#	else:
#		animated_sprite_2d.animation = "idle"
	
	var playerInput = get_input()
	
	
	velocity = lerp(velocity, playerInput*SPEED, delta*ACCEL)
	
	move_and_slide()
	
func _physics_process(delta):
	if Input.is_action_pressed("Shoot") and fire_rate_timer.time_left == 0:
		if GlobalVars.mode%2 == 0:
			smg.fireBullet()
			fire_rate_timer.wait_time = smg.fireRate


		if GlobalVars.mode%2 == 1:
			weapon.fireBullet()
			fire_rate_timer.wait_time = weapon.fireRate
		fire_rate_timer.start()
			
		
		
		
		
	if Input.is_action_just_pressed("ModeChange") and mode_change_cooldown.time_left == 0:
		ModeChanged()
		mode_change_cooldown.start()

func ModeChanged():
	GlobalVars.mode+=1
	
	if GlobalVars.mode%2 == 0:
		weapon.hide()
		smg.visible = true

	if GlobalVars.mode%2 == 1:
		smg.hide()
		weapon.visible = true

func _on_hurtbox_hurt(hitbox, damage):
	Events.add_screenshake.emit(1,0.25)
	PlayerStats.health -= 1
	blinking.play("blink")



func die():
	queue_free()
