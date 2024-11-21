extends Area2D
class_name Hurtbox

var is_invincible = false:
	set(value):
		is_invincible = value
		disable.call_deferred(value)

signal hurt(hitbox,damage)

func takeHit(hitbox , damage):
	if is_invincible:return
	
	hurt.emit(hitbox,damage)
	

func disable(value : bool):
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
