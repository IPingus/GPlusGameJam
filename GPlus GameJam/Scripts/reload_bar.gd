extends TextureRect
@onready var texture_progress_bar = $TextureProgressBar
func _ready():
	WeaponStats.weaponReloading.connect(weaponReloading)
	set_process(false)
	
	
func _process(delta):
	texture_progress_bar.value = WeaponStats.timer.time_left


func weaponReloading(weaponName):
	texture_progress_bar.max_value = WeaponStats.Ammo.get(weaponName)[2]
	set_process(true)
