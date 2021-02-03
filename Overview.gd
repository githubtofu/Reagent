extends HBoxContainer

signal top_bar_update

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_update(time):
	#var cur_time = cur_time_string.substr(0,2).to_int()
	var time_text = str(time) + "H"
	get_node("VTime").text = time_text
