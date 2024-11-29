extends StaticBody2D
class_name Removable
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@export var removedinPast :int


func _ready():
	Events.ModeChanged.connect(modechanged)
	modechanged
	
func modechanged():
	if GlobalVars.mode == removedinPast:
		sprite_2d.hide()
		collision_layer = 512
		collision_mask = 512
	else:
		sprite_2d.show()
		collision_layer = 1
		collision_mask = 1
		
