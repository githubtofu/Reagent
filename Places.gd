extends Node

var places = []
var num_districts = 0
var ids = {}
signal update_display

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("update_display", get_parent(), "_on_Places_update_display")

func on_add(sig_type, place):
	print("Adding Place:"+place["name"] + " Type:"+sig_type)
	var owner = []
	if place.has("owner"):
		owner = place["owner"]
	var capacity = 4
	if place.has("capacity"):
		capacity = place["capacity"]
	var id = place["name"].sha256_text().substr(0,10)
	while true:
		if ids.has(id):
			id = id.substr(1,10)+"x"
		else:
			ids[id] = place["name"]
			break
	places.append({"type":place["type"], "name":place["name"],
		"district":place["district"], "owner":owner, "capacity":capacity,
		"place_id":id})
	if not num_districts > place["district"]:
		num_districts = place["district"] + 1
	
	emit_signal("update_display", sig_type, places)
	
func get_places():
	return places

func get_num_districts():
	return num_districts

func get_district(id):
	for place in places:
		if place["place_id"] == id:
			return place["district"]
