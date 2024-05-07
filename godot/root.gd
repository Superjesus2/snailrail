extends Node

var which_key_is_pressed = []
var current_keys = []
var going_right = true
var starting = true
var elapsed_time = 0

var is_slowed = false
var is_snared = false
var vitesse = 0.
var backg_pos_x = 1200
var idle_duration = 0

const key_names_1 = ["E","R","T","Y","U","I"]
const key_names_2 = ["S","D","F","G","H","J","K","L"]
const key_names_3 = ["V","B","N"]
var all_key_names = key_names_1 + key_names_2 + key_names_3

const finish_line_pos_x = -550
const max_idle_duration = 1.2
const vitesse_min = 0

var spawns = {}

const animals = {
	"snail": {
			"keycodes": [KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S","D","F","G","H","J","K","L"],
			"vitesse_max": 128.
					},
	"centipede": {
			"keycodes": [KEY_S, KEY_E, KEY_R, KEY_D, KEY_V, KEY_F, KEY_T, KEY_Y, \
					KEY_G, KEY_B, KEY_N, KEY_H, KEY_U, KEY_I, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S", "E", "R", "D", "V", "F", "T", "Y", "G", \
							"B", "N", "H", "U", "I", "J", "K", "L"],
			"vitesse_max": 256.
					},
	"butterfly": {
			"keycodes": [KEY_S, KEY_E, KEY_R,KEY_U, KEY_I, KEY_L],
			"keylabels": ["S","E","R","U","I","L"],
			"vitesse_max": 64.
					},
			# TODO
}

var cur_animal_id = "snail"
var cur_animal = animals[cur_animal_id]
var expected_keys = cur_animal["keycodes"]
var expected_labels = cur_animal["keylabels"]
var vitesse_max = cur_animal["vitesse_max"]

func _ready():
	for key_name in all_key_names:
		spawns[key_name] = $spawn_spots.get_node(key_name).position


	for i in range(0,expected_keys.size()):
		var key_button = TextureButton.new()
		var key_label = Label.new()
		current_keys.append(key_button)
		$keyboard_keys.add_child(key_button)
		$keyboard_labels.add_child(key_label)
		key_button.texture_normal = load("res://resources and assets/key_sprite_normal.png")
		key_button.texture_pressed = load("res://resources and assets/key_sprite_pressed.png")
		key_button.texture_disabled = load("res://resources and assets/key_sprite_red.png")
		key_button.texture_focused = load("res://resources and assets/key_sprite_green.png")
		key_button.name = "label_" + expected_labels[i]
		key_button.toggle_mode = true
		key_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		key_label.text = expected_labels[i]
		key_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		key_label.modulate = Color("BROWN")
		key_label.position = spawns[expected_labels[i]]
		key_button.position = spawns[expected_labels[i]]
		
		
		if key_label.text in key_names_3 :
			key_button.z_index = 5
			key_label.z_index = 5
		elif key_label.text in key_names_2 :
			key_button.z_index = 4
			key_label.z_index = 4
		elif key_label.text in key_names_1 :
			key_button.z_index = 3
			key_label.z_index = 3
		
		
		# AJOUTER DES SPRITES AUX BOUTONS
		# IL FAUT QUE LES SPAWNERS EXISTENT pour le composant 'TextureButton+LABEL'

	start_snail()
	start_other_candidates()
	print(current_keys)

func _process(_delta):
# L'escargot bouge :
	$backg.position.x -= _delta * vitesse
	backg_pos_x -= _delta * vitesse
	# de moins en moins vite
	if is_slowed == true :
		vitesse -= (vitesse/100) + 0.003
	# de zéro
	if is_snared == true :
		vitesse -= 1.1
	# jamais moins de zéro :
	if vitesse < vitesse_min :
		vitesse = vitesse_min
	# jamais trop :
	if vitesse > vitesse_max :
		vitesse = vitesse_max
	# avec style :
		# ANIMATION
		if vitesse < vitesse_max/2 :
			pass
		if vitesse < vitesse_max/4 :
			pass
		if vitesse > vitesse_max/2 :
			pass
	# jusqu'au bout du monde :
	if backg_pos_x < finish_line_pos_x :
		itsa_win()
		vitesse = 0

# Le temps passe :
	idle_duration += _delta
	if idle_duration > max_idle_duration :
		is_slowed = true
	elapsed_time += _delta
	var the_timer = 60 - elapsed_time
	$chrono_timer.text = "%.2f" % the_timer

func _on_key_success():
	vitesse += 1
	is_snared = false
	is_slowed = false
func _on_key_fail():
	is_snared = true

func start_snail():
	pass
	
func start_other_candidates():
	pass
	

func itsa_win():
	print('game won')
func itsa_loose():
	print('game lost')


func validate_input(expect_key, event):
	expect_key.clear()
	for key in expect_key:
		pass

func is_event_key_pressed(event, physical_keycode):
	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo():
			if event.physical_keycode == physical_keycode:
				return true
	return false

func _input(event):
	# reset idle duration when an expected key has been pressed
	for key in expected_keys:
		if is_event_key_pressed(event, key):
#			idle_duration = 0
			pass

	var any_valid_key_has_been_pressed = \
						expected_keys.any(func(k):
			return is_event_key_pressed(event,k))
	if any_valid_key_has_been_pressed:
		idle_duration = 0
	
	
		#DEBUG
	if Input.is_physical_key_pressed(KEY_V):
		_on_key_success()
	if Input.is_physical_key_pressed(KEY_X):
		_on_key_fail()
	
	var label_S = get_node("/root/root/keyboard_keys/label_S")
	var label_D = get_node("/root/root/keyboard_keys/label_D")
	var label_F = get_node("/root/root/keyboard_keys/label_F")
	var label_G = get_node("/root/root/keyboard_keys/label_G")
	var label_H = get_node("/root/root/keyboard_keys/label_H")
	var label_J = get_node("/root/root/keyboard_keys/label_J")
	var label_K = get_node("/root/root/keyboard_keys/label_K")
	var label_L = get_node("/root/root/keyboard_keys/label_L")
	
	
		# UNE METHODE MOINS LABORIEUSE ?
#	if escargo == true:
#		var expected_keys = ["S", "D"]
#		validate_input([14,2,3], event)
		
		
#	if Input.is_physical_key_pressed(KEY_S):
#		if starting == true:
#			if label_S.button_pressed == false:
#				print("S, go to D")
#				label_S.button_pressed = true
#				starting = false
#			else:
#				print('fail')
#		else:
#			if label_S.button_pressed == false and label_D.button_pressed == true:
#				print("S, go to D")
#				going_right = true
#			else:
#				print('fail')
#		if Input.is_physical_key_pressed(KEY_D):
#			if going_right == true:
#				if label_D.button_pressed == false and label_S.button_pressed == true:
#					print("D, go to F")
#				else:
#					print('fail')
#			else:
#				if label_D.button_pressed == false and label_F.button_pressed == true:
#					print("D, go to S")
#				else:
#					print('fail')
	#	if Input.is_physical_key_pressed(KEY_F):
	#	if Input.is_physical_key_pressed(KEY_G):
	#	if Input.is_physical_key_pressed(KEY_H):
	#	if Input.is_physical_key_pressed(KEY_J):
	#	if Input.is_physical_key_pressed(KEY_K):
	#	if Input.is_physical_key_pressed(KEY_L):

#	else if millepatte == true
		#	if Input.is_physical_key_pressed(KEY_F):
		#	if Input.is_physical_key_pressed(KEY_G):
		#	if Input.is_physical_key_pressed(KEY_H):
		#	if Input.is_physical_key_pressed(KEY_J):
		#	if Input.is_physical_key_pressed(KEY_K):
