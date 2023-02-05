extends Container

var bar1 : TextureProgress
var bar2 : TextureProgress
var gun1 : Node = null
var gun2 : Node = null
var tween : Tween

var baseTints : PoolColorArray = [Color("00258b"), Color("c00000"), Color("ffef00")]
enum BASETINTS {Blue, Red, Yellow}



func _ready():
	tween = GlobalReferences.tween
	bar1 = $Under/HBoxCont/Bar1
	bar2 = $Under/HBoxCont/Bar2


func update_ammo_bar():
	bar1.tint_progress = GlobalReferences.colours[gun1.gunType]
	tween.interpolate_property(bar1, "value", bar1.value, gun1.ammoCount, 0.2)
	tween.interpolate_property(bar2, "value", bar2.value, 0, 0.2)
	if not tween.is_active():
		tween.start()



func update_mixed_ammo_bar():
	bar1.tint_progress = GlobalReferences.colours[gun1.gunType]
	bar2.tint_progress = GlobalReferences.colours[gun2.gunType]
	
	tween.interpolate_property(bar1, "value", bar1.value, gun1.ammoCount, 0.2)
	tween.interpolate_property(bar2, "value", bar2.value, gun2.ammoCount, 0.2)
	if not tween.is_active():
		tween.start()







