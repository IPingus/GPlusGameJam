extends Area2D
class_name Hurtbox

signal hurt(hitbox,damage)

func takeHit(hitbox,damage):
	print("ouch")
	hurt.emit(hitbox,damage)
