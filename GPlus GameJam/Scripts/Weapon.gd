extends Node2D
class_name Weapon

@onready var sprite_2d = $Sprite2D
@onready var muzzle = $Sprite2D/Muzzle

@export var fireRate = 1.0 
@export var damage :float
@export var armorPierce :float

@export var BULLETS : PackedScene

func _process(delta):
	sprite_2d.rotation = get_local_mouse_position().angle()

	
		
func fireBullet():
	var bullet = Utils.instanceSceneOnMain(BULLETS, muzzle.global_position)
	bullet.setstats(damage,armorPierce)
	bullet.rotation = sprite_2d.rotation
	bullet.update_velocity()
	
