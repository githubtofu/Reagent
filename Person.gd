extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var medict = {
#		"name":person["name"],
#		"Home":"None",
#		"Work":"None",
#		"movement_interval":1,
#		"till_movement":1,
#		"money":100,
#		"personal_id":id
		}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pdict):
	for key in pdict:
		medict[key] = pdict[key]
	if not medict.has("name"):
		medict["name"] = "None"
	if not medict.has("Home"):
		medict["Home"] = "None"
	if not medict.has("Work"):
		medict["Work"] = "None"
	else:
		medict["work_starts_at"] = 9
		medict["work_ends_at"] = 17
	if not medict.has("current_origin"):
		medict["current_origin"] = -1
	if not medict.has("current_dest"):
		medict["current_dest"] = -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_name():
	return medict["name"]

func get_current_district():
	var retval = -1
	if medict["current_origin"] < 0 and medict["current_dest"] >= 0:
		retval = medict["current_dest"]
	print("===============")
	print("GETCURDIST:"+"name:"+medict["name"]+" origin:" + str(medict["current_origin"])+
		" dest:"+str(medict["current_dest"]) + " returning:"+str(retval))
	return retval

func get_available_home(places):
	for place in places:
		if place["type"] == "house":
			if place["owner"].size() < place["capacity"]:
				return place
	return {}

func get_available_job(places):
	for place in places:
		if place["type"] == "company":
			return place
	return {"type":"None"}

func update_person(t, places):
	if medict["Home"] == "None":
		var home = get_available_home(places.get_places())
		if home.has("owner"):
			home["owner"].append(medict["personal_id"])
			medict["Home"] = home["place_id"]
			print("GOT NEW HOME:" + home["name"])
		else:
			print("No home available")
		print("for "+ medict["personal_id"] + " " + medict["name"])
	var need_home = medict["Work"] == "None"
	if need_home:
		var work = get_available_job(places.get_places())
		if not work["type"] == "None":
			medict["Work"] = work["place_id"]
			medict["work_starts_at"] = 9
			medict["work_ends_at"] = 17
	get_movement(t, medict, places)
	print("MOVEMENT:DEST:"+str(medict["current_dest"]))
	
				
func get_movement(t, dict, places):
	print("GETTING MOVEMENT:from "+str(dict["current_origin"]) + " to " + str(dict["current_dest"]) + " at Time "+str(t))
	print("WORK " + dict["Work"] + " Home " + dict["Home"])
	if dict["current_origin"] < 0:
		if dict["current_dest"] < 0:
			if dict["Home"] == "None":
				dict["current_dest"] = 0
			else:
				if dict["Work"] == "None":
					if not dict["Home"] == "None":
						dict["current_dest"] = places.get_district(dict["Home"])
						print("AA:"+str(dict["current_dest"]))
				else:
					var working = is_working(t, dict["work_starts_at"], dict["work_ends_at"])
					if working == 1 or working == 3:
						dict["current_dest"] = places.get_district(dict["Work"])
						if working == 1:
							dict["current_origin"] = places.get_district(dict["Home"])
					elif working == 0 or working == 2:
						dict["current_dest"] = places.get_district(dict["Home"])
						if working == 2:
							dict["current_origin"] = places.get_district(dict["Work"])
					print("GOT MOVEMENT "+ str(dict["current_origin"]) + " to " + str(dict["current_dest"]))
		else:
			dict["current_origin"] = dict["current_dest"]
			var working = is_working(t, dict["work_starts_at"], dict["work_ends_at"])
			print("IS Working:"+str(working))
			if working == 1 or working == 3:
				dict["current_dest"] = places.get_district(dict["Work"])
			elif working == 0 or working == 2:
				dict["current_dest"] = places.get_district(dict["Home"])
				print("CURDEST:"+str(dict["current_dest"]))
			if dict["current_origin"] == dict["current_dest"]:
				dict["current_origin"] = -1
	else:
		if dict["current_dest"] < 0:
			dict["current_dest"] = dict["current_origin"]
		dict["current_origin"] = -1
			

func is_working(t, wstart, wend):
	if wstart - 1 <= t and t < wend + 1:
		if t < wstart:
			return 1
		if wend <= t:
			return 2
		return 3
	else:
		return 0
