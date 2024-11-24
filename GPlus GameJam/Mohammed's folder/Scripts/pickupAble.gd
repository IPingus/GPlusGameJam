extends Area2D
class_name pickupAble

signal picked(type:int)

#var is_invincible = false:
	#set(value):
		#is_invincible = value
		#disable.call_deferred(value)

func pickUp(type):
	print("PICK")
	picked.emit(type)

func disable(value : bool):
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
