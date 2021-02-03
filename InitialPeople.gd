extends Node


signal add
var map = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("add", owner.get_node("People"), "on_add")

func set_initial_people():
	emit_signal("add", "person", {"name":"John John"})
#	emit_signal("add", "person", {"type":"house", "name":"Generic House", "district":1})
