extends Node2D

@onready var camera_2d = $Camera2D
@onready var checkponts = $Checkponts
@onready var enemies = $Enemies
var checkpoitn = 0 #: set = chekcpointChanged
@onready var player = %Player

var checkponintlist
var AreaCleared = false
var AllEnemylist
var checkEnemies
var nullindex = 0

func _ready():
	Events.enemydied.connect(on_enemy_enemydied)
	checkponintlist = checkponts.get_children()
	AllEnemylist = enemies.get_children()
	chekcpointChanged(checkpoitn)


func _on_checkpoint_player_entered():
	if checkponintlist.size() > checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)
		


func on_enemy_enemydied():
	nullindex = checkEnemies.find(null)
	checkEnemies.pop_at(nullindex)
	if checkEnemies.size()==0:
		AreaCleared = true
	else:AreaCleared = false
	
	
func chekcpointChanged(value):
	if AllEnemylist.size() > checkpoitn:
		checkEnemies=AllEnemylist[value].get_children()
	for i in checkEnemies:
		i.player_path =  NodePath("../../../Player")
		
