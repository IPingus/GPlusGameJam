extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerStats.health = PlayerStats.max_health
		queue_free()
