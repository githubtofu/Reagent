extends Node2D

var MAX_HOUR = 24
var cur_time = 12

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_pressed():
	$TimerUpdate.start(1)
	$InitialMap.set_initial_map()
	$InitialPeople.set_initial_people()


func _on_Places_update_display(sig_type, items):
	print("ON PLACE UPDATE ")
	$Log.text = sig_type
	if sig_type == "place":
		$varrange/Districts.update_display($Places, $People)

func _on_People_update_display(items):
	$varrange/Districts.update_display($Places, $People)
	print("ON People UPDATE ")

func _on_TimerUpdate_timeout():
	cur_time += 1
	cur_time %= MAX_HOUR
	$varrange/Overview._on_update(cur_time)
	$People._on_update(cur_time, $Places)
	$varrange/TopColorBar._on_update(cur_time)
