extends Area2D


signal PlayerEntered()



func _on_area_entered(area):
	if area.is_in_group("Player"):
		PlayerEntered.emit()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		PlayerEntered.emit()
