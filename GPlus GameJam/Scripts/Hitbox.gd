extends Area2D
class_name Hitbox

@export var damage :float
@export var armorPierce :float
@export var layer : int
 
func _on_area_entered(hurtbox):
	print("on_area_entered")
	if not hurtbox is Hurtbox: return
	print("on_area_entered222")
	hurtbox.takeHit(self,damage,armorPierce)
