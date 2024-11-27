extends CharacterBody2D
class_name Player

@export var SPEED = 80.0
@export var ACCEL = 100
#@onready var animated_sprite_2d = $AnimatedSprite2D
var input: Vector2
var weapon:Weapon


@onready var fire_rate_timer = $FireRateTimer
@onready var mode_change_cooldown = $ModeChangeCooldown
@onready var hurtbox = $Hurtbox
@onready var blinking = $Blinking
@onready var smg = $SMG
@onready var crossbow = $Crossbow
@onready var state_chart = $StateChart

@onready var reload_bar = $ReloadBar
@onready var healt = $Healt
@onready var sprite_2d_2 = $Sprite2D2
@onready var mode_switch = $modeSwitch
@onready var animation_player = $AnimationPlayer
@onready var flip_animation = $Sprite2D2/FlipAnimation
var facingLeft=true

#signal ModeChangedSig()

func _ready():
	PlayerStats.no_health.connect(die)
	Events.ModeChanged.connect(ModeChanged)
	WeaponStats.weaponReloading.connect(weaponReloading)
	WeaponStats.weaponDoneReloading.connect(weaponDoneReloading)
	ModeChanged()

func	get_input():
	input.x = Input.get_action_raw_strength("Right") -  Input.get_action_raw_strength("Left")
	input.y = Input.get_action_raw_strength("Down") -  Input.get_action_raw_strength("Up")
	return input.normalized()
	
func weaponReloading(weaponName):
	if reload_bar.hidden:
		reload_bar.show()

func weaponDoneReloading(weaponName):
	print(weaponName)
	reload_bar.hide()

func _process(delta):
	pass
#	if (velocity.x != 0 || velocity.y != 0 ):
#		animated_sprite_2d.animation = "move"
#	else:
#		animated_sprite_2d.animation = "idle"

	#if get_local_mouse_position().angle()<-1.8 or get_local_mouse_position().angle()>1.2:
		#sprite_2d_2.flip_h = false
		#weapon.sprite_2d.flip_v=true
	#else:
		#sprite_2d_2.flip_h = true
		#weapon.sprite_2d.flip_v=false
	#
	#var playerInput = get_input()
	#
	#
	#velocity = lerp(velocity, playerInput*SPEED, delta*ACCEL)
	#animation_player.play("walk")
	#
	#move_and_slide()
	
func _physics_process(delta):
	if Input.is_action_pressed("Shoot") and fire_rate_timer.is_stopped() and mode_switch.time_left==0:
		weapon.fireBullet()
		fire_rate_timer.start(weapon.fireRate)
	if not facingLeft and (weapon.sprite_2d.rotation<-1.8 or weapon.sprite_2d.rotation>1.2):
		#sprite_2d_2.flip_h = false
		weapon.sprite_2d.flip_v=true
		flip_animation.play("FlipToLeft")
		facingLeft=true
	elif facingLeft and not (weapon.sprite_2d.rotation<-1.8 or weapon.sprite_2d.rotation>1.2):
		#sprite_2d_2.flip_h = true
		weapon.sprite_2d.flip_v=false
		flip_animation.play("FlipToRight")
		facingLeft=false
	
	var playerInput = get_input()
	
	
	velocity = lerp(velocity, playerInput*SPEED, delta*ACCEL)
	animation_player.play("walk")
	
	move_and_slide()
		
func ModeChanged():
	#GlobalVars.mode+=1
	mode_switch.start()
	fire_rate_timer.stop()
	state_chart.send_event("ModeChange")
	#ModeChangedSig.emit()
	
	#if GlobalVars.mode == 2:
		#
		#crossbow.hide()
		#smg.visible = true
		#weapon = smg
#
	#elif GlobalVars.mode== 1:
		#smg.hide()
		#crossbow.visible = true
		#weapon = crossbow

func _on_hurtbox_hurt(hitbox, damage,armorPierce):
	Events.add_screenshake.emit(1,0.25)
	PlayerStats.health-= damage
	healt.text = str(PlayerStats.health)
	blinking.play("blink")



func die():
	PlayerStats.health=PlayerStats.max_health
	Utils.moveToScene("res://menu.tscn")


func _on_past_state_entered():
	smg.hide()
	crossbow.visible = true
	weapon = crossbow


func _on_future_state_entered():
	crossbow.hide()
	smg.visible = true
	weapon = smg
