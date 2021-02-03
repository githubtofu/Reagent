extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_brightness(cur_time):
	var brightness = 0
	if cur_time < 6 or cur_time > 18:
		brightness = .25
	else:
		brightness = sin((cur_time+3) * PI / 6)	/ 8 + 0.415
	print (brightness)
	return brightness

func _on_update(cur_time):
	var brightness = get_brightness(cur_time)
	var top_color = Color(135 * brightness/(256),206 * brightness/(256),
		235 * brightness / 256)
	color = top_color
	
