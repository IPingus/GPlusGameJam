extends Node

var lastWeaponUsed

@onready var timer = $Timer

var Ammo ={"SMG":[20,20,2,false] , "Crossbow":[1,1,1,false]}
#[0 is the max ammo count], 
#[1 is the current ammo count]
#[2 is the reload time]
#[3 reload bool]

signal weaponReloading(WeaponName:String)
signal weaponDoneReloading(WeaponName:String)

signal ShotFired(WeaponName:String)

func firedShot(WeaponName):
	lastWeaponUsed = WeaponName
	if Ammo.get(WeaponName)[1] == 0:
		weaponReloading.emit(WeaponName)
		timer.start(Ammo.get(WeaponName)[2])
		Ammo.get(WeaponName)[3] = true
	else:
		ShotFired.emit(WeaponName)
		Ammo.get(WeaponName)[1] -= 1


func reload(WeaponName):
	weaponDoneReloading.emit(WeaponName)
	Ammo.get(WeaponName)[1] = Ammo.get(WeaponName)[0]
	Ammo.get(WeaponName)[3] = false


func _on_timer_timeout():
	reload(lastWeaponUsed)
