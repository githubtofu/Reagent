extends Node


var people = []
var ids = {}

var Person = preload("res://Scenes/Person.tscn")

signal update_display

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("update_display", get_parent(), "_on_People_update_display")

func on_add(sig_type, person):
	print("Adding Person:"+person["name"] + " Type:"+sig_type)
	var id = person["name"].sha256_text().substr(0,10)
	while true:
		if ids.has(id):
			id = id+"x"
		else:
			ids[id] = person["name"]
			break
	
	var p = Person.instance()
	person["personal_id"] = id
	p.init(person)	
	people.append(p)
	emit_signal("update_display", people)
	
#	emit_signal("update_display", sig_type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_people():
	return people

func _on_update(t, places):
	for person in people:
		person.update_person(t, places)
	emit_signal("update_display", people)	
	
