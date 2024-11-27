extends Control
@onready var label = $Label

func _ready():
	WeaponStats.ShotFired.connect(ShotFired)
	if WeaponStats.lastWeaponUsed is String:
		label.text = str(WeaponStats.Ammo.get(WeaponStats.lastWeaponUsed)[0])+ "/" +str(WeaponStats.Ammo.get(WeaponStats.lastWeaponUsed)[1])

func ShotFired(WeaponName):
	label.text = str(WeaponStats.Ammo.get(WeaponName)[0])+ "/" +str(WeaponStats.Ammo.get(WeaponName)[1])
	
