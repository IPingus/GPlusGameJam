extends Area2D
class_name Checkpoint

signal PlayerEntered(Area:Area2D)

var area = self



func _on_body_entered(body):
	if body.is_in_group("Player"):
		PlayerEntered.emit(area)
