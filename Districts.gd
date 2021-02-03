extends HBoxContainer

var num_all_districts = 10

var districts = []

var l_theme = preload("res://Themes/MenuTexts.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(num_all_districts):
		pass

func clear_district_labels(districts):
	for i in range(districts.size()):
		districts[i].get_child(0).text = ""
		districts[i].get_child(1).text = ""

func add_place_to_district(dist, place):
	dist.get_child(0).text += place["name"]
	if place.has("owner") and place["owner"].size() > 0:
		dist.get_child(0).text += " owned by:" + place["owner"][0]
#	dist.get_child(1).text += place["name"]

func add_person_to_district(dist, person):
	dist.get_child(1).text += person.get_name()

func update_display(places, people):
	var num_districts = places.get_num_districts()
	for i in range(districts.size(), places.get_num_districts()):
		var place_label = Label.new()
		var people_label = Label.new()
		place_label.theme = l_theme
		place_label.rect_min_size = Vector2(120,0)
		people_label.theme = l_theme
		var vbox = VBoxContainer.new()
		vbox.add_child(place_label)
		vbox.add_child(people_label)
		districts.append(vbox)
		add_child(vbox)

	clear_district_labels(districts)
		
	for place in places.get_places():
		add_place_to_district(districts[place["district"]], place)
	for person in people.get_people():
		if person.get_current_district() >= 0:
			var curdist = person.get_current_district()
			print("CURDIST for person:"+ str(curdist))
			add_person_to_district(districts[curdist], person) 

		
	
