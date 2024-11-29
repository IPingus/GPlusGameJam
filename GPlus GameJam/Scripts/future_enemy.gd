extends Enemy
class_name Shooting_Enemy
@onready var fire_rate = $FireRate
@onready var ray_cast_2d = $RayCast2D
var bullet:	Projectile

func _process(delta):
	if active:
		if playerNode is Player:
			ray_cast_2d.target_position = to_local(playerNode.global_position)
	if ray_cast_2d.is_colliding():
		if ray_cast_2d.get_collider().is_in_group("Player"):
			moving=false
			velocity=velocity.move_toward(Vector2.ZERO,acceleration*0.8*delta)
			Timeline.send_event("LOS Found")


func _on_not_state_entered():
	moving=true


func _on_yes_state_processing(delta):
	if fire_rate.time_left==0 and playerNode is Player:
		bullet = Utils.instanceSceneOnMain(BULLETS,global_position)
		bullet.hitbox.collision_mask=9
		bullet.rotation =to_local(playerNode.global_position).angle()
		bullet.update_velocity()
		bullet.setstats(2,0)
		fire_rate.start(fireRate)
	if ray_cast_2d.is_colliding():
		if not ray_cast_2d.get_collider().is_in_group("Player"):
			Timeline.send_event("LOS Lost")
	else:Timeline.send_event("LOS Lost")
