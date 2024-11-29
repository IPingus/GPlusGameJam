extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		for i in WeaponStats.Ammo.keys():
			WeaponStats.Ammo.get(i)[1] = WeaponStats.Ammo.get(i)[0]
		queue_free()
