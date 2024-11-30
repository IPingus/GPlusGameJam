extends Node2D
class_name Projectile


@export var speed = 500
@onready var hitbox = $Hitbox
const REFLECT = preload("res://reflect.tscn")
var velocity = Vector2.ZERO
func setstats(damage,armorPeirce):
	hitbox.damage = damage
	hitbox.armorPierce = armorPeirce


func update_velocity():
	velocity.x = speed
	velocity = velocity.rotated(rotation)

func _process(delta):
		position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_hitbox_area_entered(area):
	if area is Hurtbox:
		if area.armor-5 > hitbox.armorPierce*25:
			Utils.instanceSceneOnMain(REFLECT,global_position)
	queue_free()


func _on_hitbox_body_entered(body):
	if body is Hurtbox:
		if body.armor > hitbox.armorPierce+7:
			Utils.instanceSceneOnMain(REFLECT,global_position)
	print("body")
	queue_free()
