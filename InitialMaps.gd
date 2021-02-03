extends Node


signal add
var map = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("add", owner.get_node("Places"), "on_add")

func set_initial_map():
	emit_signal("add", "place", {"type":"company", "name":"DefCom", "district":0})
	emit_signal("add", "place", {"type":"house", "name":"Generic House", "district":1})
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
