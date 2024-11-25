extends CharacterBody2D
@onready var ray_cast_2d = $RayCast2D
@export var player:CharacterBody2D

func _process(delta):
	ray_cast_2d.target_position = to_local(player.position)
	
