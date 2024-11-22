extends Node2D

@onready var sprite_2d = $Sprite2D

@onready var muzzle = $Sprite2D/Muzzle

#const BULLET = preload("res://Scenes/bullet.gd")
const BULLET = preload("res://Scenes/bullets.tscn")
func _process(delta):
	sprite_2d.rotation = get_local_mouse_position().angle()
	
func fireBullet():
	var bullet = Utils.instanceSceneOnMain(BULLET, muzzle.global_position)
	bullet.rotation = sprite_2d.rotation
	bullet.update_velocity()
	
