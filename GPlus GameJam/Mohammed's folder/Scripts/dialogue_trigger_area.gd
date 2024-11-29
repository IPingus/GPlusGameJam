extends Area2D

@export var dialougeResource: DialogueResource
@export var dialougeStart: String = "this_is_a_node_title" # هذي هي العنوان المكتوب بالوردي في صفحة الdialogue 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		DialogueManager.show_dialogue_balloon(dialougeResource,dialougeStart)
