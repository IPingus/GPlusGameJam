extends Area2D
class_name Hurtbox

signal hurt(hitbox,damage,armorPierce)

var is_invincible = false:
	set(value):
		is_invincible = value
		disable.call_deferred(value)

func takeHit(hitbox,damage,armorPierce=0):
	print("ouch")
	hurt.emit(hitbox,damage,armorPierce)

func disable(value : bool):
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
