extends Node2D

@onready var camera_2d = $Camera2D
@onready var checkponts = $Checkponts
@onready var enemies = $Enemies
var checkpoitn = 0 #: set = chekcpointChanged
@onready var player = %Player
@onready var walls = $Walls
@onready var backtrackwalls = $Backtrackwalls
@onready var mideval = $Mideval
@onready var future = $Future



var checkponintlist
var AreaCleared = false
var AllEnemylist
var checkEnemies
var nullindex = 0
var WallsList
var backtrackwallList
func _ready():
	
	Events.enemydied.connect(on_enemy_enemydied)
	Events.ModeChanged.connect((modechanged21))
	checkponintlist = checkponts.get_children()
	AllEnemylist = enemies.get_children()
	WallsList = walls.get_children()
	backtrackwallList = backtrackwalls.get_children()
	disableallwalls()
	chekcpointChanged(checkpoitn)
	modechanged21()
	
func modechanged21():
	if GlobalVars.mode%2 == 1 :
		mideval.show()
		future.hide()
	future
	if GlobalVars.mode%2 == 0 :
		mideval.hide()
		future.show()



func _on_checkpoint_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)
		


func on_enemy_enemydied():
	nullindex = checkEnemies.find(null)
	checkEnemies.pop_at(nullindex)
	if checkEnemies.size()==0:
		if WallsList.size()>checkpoitn:
			WallsList[checkpoitn].queue_free()
		AreaCleared = true
	else:AreaCleared = false
	
	
func chekcpointChanged(value):
	if AllEnemylist.size() > checkpoitn:
		checkEnemies=AllEnemylist[checkpoitn].get_children()
	if WallsList.size()>checkpoitn :
				WallsList[checkpoitn].collision_layer= 1
	if backtrackwallList.size()>=checkpoitn and checkpoitn>0:
				backtrackwallList[checkpoitn-1].collision_layer= 1
	for i in checkEnemies:
		i.player_path =  NodePath("../../../Player")
		
func disableallwalls():
	for child in WallsList:
		if child is StaticBody2D or child is CollisionPolygon2D:
			child.collision_layer= 32
	for child in backtrackwallList:
		if child is StaticBody2D or child is CollisionPolygon2D:
			child.collision_layer= 32
	


func _on_checkpoint_1_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)


func _on_checkpoint_2_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)


func _on_checkpoint_3_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)


func _on_checkpoint_4_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)


func _on_checkpoint_5_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)


func _on_checkpoint_6_player_entered():
	if checkponintlist.size() >= checkpoitn and AreaCleared:
		AreaCleared = false
		camera_2d.global_position = checkponintlist[checkpoitn].global_position
		checkpoitn+=1
		chekcpointChanged(checkpoitn)

func _on_checkpoint_8_player_entered():
	Utils.moveToScene("res://menu.tscn")
