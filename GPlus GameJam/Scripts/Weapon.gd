extends Node2D
class_name Weapon

var mouseUsed =false
var WeaponName
@export var fireRate = 1.0 
@export var damage :float
@export var armorPierce :float
@export var animationPlayer:AnimationPlayer
@export var RecoilAnimationName: String
@export var BULLETS : PackedScene

@onready var sprite_2d = $Sprite2D
@onready var muzzle = $Sprite2D/Muzzle
@onready var audio_stream_player = $AudioStreamPlayer
@onready var sprite_2d_2 = $Sprite2D/Sprite2D2

const DUST_EFFECT = preload("res://DustEffect.tscn")

func _ready():
	WeaponName =self.get_name()
	
func _input(event):
	if event is InputEventMouseMotion:
		mouseUsed =true

func _process(delta):
	var turn_vector = 0.0
	var last_vector =0.0
	var xAxis = Input.get_joy_axis(0,JOY_AXIS_RIGHT_X)
	var yAxis = Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y)
	if mouseUsed:
		sprite_2d.rotation = get_local_mouse_position().angle()
		sprite_2d_2.hide()
	if xAxis ==0.0 and yAxis==0.0:
		turn_vector = last_vector
	else:
		sprite_2d_2.show()
		turn_vector = Vector2(xAxis,yAxis).angle()
		mouseUsed =false
		last_vector=turn_vector
		var newRotation = lerp_angle(rotation,turn_vector,1)
		sprite_2d.rotation = newRotation

func fireBullet():
	if(not WeaponStats.Ammo.get(WeaponName)[3]):
		print(WeaponStats.Ammo.get(WeaponName)[1])
		WeaponStats.firedShot(WeaponName)
		var bullet = Utils.instanceSceneOnMain(BULLETS, muzzle.global_position)
		var Dust = Utils.instanceSceneOnMain(DUST_EFFECT,muzzle.global_position)
		Dust.amount = 2
		Dust.scale.x = 0.1
		Dust.scale.y = 0.1
		audio_stream_player.pitch_scale=randf_range(0.8,1.2)
		audio_stream_player.play()
		bullet.setstats(damage,armorPierce)
		bullet.rotation = sprite_2d.rotation
		bullet.update_velocity()
		if animationPlayer is AnimationPlayer:
			animationPlayer.play(RecoilAnimationName)
	
