extends CharacterBody2D
class_name PastEnemy

@export var acceleration = 150
@export var max_speed = 300
@export var player_path: NodePath

@onready var sprite_2d = $Sprite2D


func _physics_process(delta):
	if player_path is NodePath:
		var player = get_node(player_path)
		if player is CharacterBody2D:
			move_toward_postion(player.global_position, delta)
	if Input.is_action_pressed("ModeChange"):
		print("dsada")
		changed_mode()
func changed_mode():
	if GlobalVars.mode%2 == 0 and is_in_group("Past"):
		print("first")
		max_speed = 30
		acceleration = 150

	if GlobalVars.mode%2 == 1 and is_in_group("Past"):
		print("second")
		max_speed = 500
		acceleration = 400

	if GlobalVars.mode%2 == 0 and is_in_group("Future"):
		max_speed = 300
		acceleration = 150

	if GlobalVars.mode%2 == 1 and is_in_group("Future"):
		max_speed = 20
		acceleration = 150
func move_toward_postion(target_position, delta):

	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(max_speed*direction,acceleration*delta)
	sprite_2d.flip_h = global_position < target_position
	
	move_and_slide()
