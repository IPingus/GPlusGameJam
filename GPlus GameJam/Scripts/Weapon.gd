extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var muzzle = $Sprite2D/Muzzle

@export var fireRate = 1.0 
@export var damage :float
@export var armorPierce :float

const BULLETS = preload("res://Scenes/bullets.tscn")

func _process(delta):
	sprite_2d.rotation = get_local_mouse_position().angle()
	
func fireBullet():
	var bullet = Utils.instanceSceneOnMain(BULLETS, muzzle.global_position)
	bullet.setstats(damage,armorPierce)
	bullet.rotation = sprite_2d.rotation
	bullet.update_velocity()
	
