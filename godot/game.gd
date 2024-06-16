extends Node

var elapsed_time = 0
var the_timer = 0
var start_timer = 3
var game_over
var starting = true

var is_slowed = false
var is_snared = false
var vitesse = 0.
var player_pos_x = 0
var idle_duration = 0

const key_names_1 = ["E","R","T","Y","U","I"]
const key_names_2 = ["S","D","F","G","H","J","K","L"]
const key_names_3 = ["V","B","N"]
var all_key_names = key_names_1 + key_names_2 + key_names_3
var button_nodes = []
var label_nodes = []

const finish_line_pos_x = 2500
const max_idle_duration = 1.2
const vitesse_min = 0

var key_sprite_normal = load("res://resources and assets/GUI/key_sprite_normal.png")
var key_sprite_pressed = load("res://resources and assets/GUI/key_sprite_pressed.png")
var key_sprite_red = load("res://resources and assets/GUI/key_sprite_red.png")
var key_sprite_green = load("res://resources and assets/GUI/key_sprite_green.png")

var spawns = {}

var cur_animal_id = globals.players[globals.player_selected]
var cur_animal = globals.animals[cur_animal_id]
var player_sprite = cur_animal["sprite"]
var keys_for_this_animal__keys = cur_animal["keycodes"]
var keys_for_this_animal__labels = cur_animal["keylabels"]
var vitesse_max = cur_animal["vitesse_max"]
var can_go_left = cur_animal["can go left"]

# input system
var going_right = true
var expected_key = keys_for_this_animal__keys[0]

func back():
	get_tree().change_scene_to_file("res://root.tscn")

func _ready():

	globals.first_try = false
	%back_button.pressed.connect(func():back())
	%retry_button.pressed.connect(func():retry())
	$player.texture = load(player_sprite[0])
	
	for key_name in all_key_names:
		spawns[key_name] = $spawn_spots.get_node(key_name).position

	for i in range(0,keys_for_this_animal__keys.size()):
		var key_button = TextureButton.new()
		var key_label = Label.new()
		%keyboard_keys.add_child(key_button)
		%keyboard_labels.add_child(key_label)
		button_nodes.append(key_button)
		label_nodes.append(key_label)
		key_label.name = "labelled_" + keys_for_this_animal__labels[i]
		key_button.name = "label_" + keys_for_this_animal__labels[i]
		key_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		key_label.text = keys_for_this_animal__labels[i]
		key_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		key_label.modulate = Color("BROWN")
		key_label.position = spawns[keys_for_this_animal__labels[i]]
		key_button.position = spawns[keys_for_this_animal__labels[i]]
		key_button.texture_normal = key_sprite_normal
		
		if key_label.text in key_names_3 :
			key_button.z_index = 5
			key_label.z_index = 5
		elif key_label.text in key_names_2 :
			key_button.z_index = 4
			key_label.z_index = 4
		elif key_label.text in key_names_1 :
			key_button.z_index = 3
			key_label.z_index = 3
		
		if key_button == button_nodes[0] :
			key_button.texture_normal = key_sprite_green
		# AJOUTER DES SPRITES AUX BOUTONS
		# IL FAUT QUE LES SPAWNERS EXISTENT pour le composant 'TextureButton+LABEL'

func _process(_delta):
	
# L'escargot bouge :
	$player.position.x += _delta * vitesse
	player_pos_x += _delta * vitesse
	# de moins en moins vite
	if is_slowed == true :
		vitesse -= (vitesse/80) + 0.004
	# de zéro
	if is_snared == true :
		vitesse -= 1.2
	# jamais moins de zéro :
	if vitesse < vitesse_min :
		vitesse = vitesse_min
	# jamais trop :
	if vitesse > vitesse_max :
		vitesse = vitesse_max
	# avec style :
		# ANIMATION
	if vitesse < vitesse_max/3 :
		$player.texture = load(player_sprite[0])
	if vitesse < vitesse_max/1.5 and vitesse > vitesse_max/3 :
		$player.texture = load(player_sprite[1])
	if vitesse > vitesse_max/1.5 :
		$player.texture = load(player_sprite[2])
	if is_snared and not vitesse == 0 :
		$player.texture = load(player_sprite[3])
	if vitesse == 0 :
		$player.texture = load(player_sprite[0])
	# jusqu'au bout du monde :
	if player_pos_x > finish_line_pos_x :
		itsa_win()
	# jusqu'à la mort
	if the_timer < 0 :
		itsa_loose()

	# Le temps passe :
	if not game_over :
		%chrono_timer.text = "%.2f" % the_timer + 's'
		globals.distance = "%.0f" % (player_pos_x/5)
	idle_duration += _delta
	if idle_duration > max_idle_duration :
		is_slowed = true
	elapsed_time += _delta
	the_timer = 60 - elapsed_time
	# L'espace tend :
	%distance_counter.text = str(globals.distance) + ' m'
	# Le score s'tasse :
	%error_counter.text = str(globals.errors)

func retry():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_key_success():
	vitesse += 1
	is_snared = false
	is_slowed = false
	idle_duration = 0
func _on_key_fail():
	is_snared = true
	idle_duration = 0

func itsa_win():
	if not game_over :
		globals.time = "%.2f" % the_timer
		%chrono_timer.text = globals.time
		scores()
		%back_button.visible = true
		%keyboard_keys.visible = false
		%keyboard_labels.visible = false
	game_over = true
	vitesse = 0

func itsa_loose():
	if not game_over :
		if the_timer < 0 :
			the_timer = 0
		globals.time = snapped(the_timer, 0.01)
		%chrono_timer.text = "%.2f" % globals.time + 's'
		scores()
		%back_button.visible = true
		%retry_button.visible = true
		%keyboard_keys.visible = false
		%keyboard_labels.visible = false
	game_over = true
	vitesse = 0

func scores():
		globals.high_scores.append([globals.players[globals.player_selected],\
									globals.time,\
									globals.distance,\
									globals.errors])
		print(globals.high_scores)
		globals.times_played += 1

func validate_input(expect_key, _event):
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
	
	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo():
			if event.physical_keycode == expected_key:
				
				for all in label_nodes :
					if keys_for_this_animal__keys.find(event.physical_keycode) != -1 :
						pass
				
				_on_key_success()
				for all in button_nodes :
					all.texture_normal = key_sprite_normal
				var my_index = keys_for_this_animal__keys.find(expected_key)
				var after_index
				
				if can_go_left :
					if going_right and expected_key == keys_for_this_animal__keys[-1]:
						going_right = false
					elif not going_right and expected_key == keys_for_this_animal__keys[0]:
						going_right = true
				else:
					pass
				
				if can_go_left :
					var offset = 1 if going_right else -1
					expected_key = keys_for_this_animal__keys[my_index + offset]
					after_index = my_index + offset
				else :
					var offset = 1
					if my_index == (keys_for_this_animal__keys.size() - 1) :
						after_index = 0
						my_index = -1
					expected_key = keys_for_this_animal__keys[my_index + offset]
					after_index = my_index + offset
				
				button_nodes[my_index].texture_normal = key_sprite_pressed
				button_nodes[after_index].texture_normal = key_sprite_green
			elif event.physical_keycode == KEY_ESCAPE :
				itsa_loose()
			else:
				if not game_over :
					_on_key_fail()
					globals.errors += 1
					var pressed_key = keys_for_this_animal__keys.find(event.physical_keycode)
					if pressed_key != -1 :
						button_nodes[pressed_key].texture_normal = key_sprite_red
					else:
						_shake_keyboard()

@onready var base_pos_labels = %keyboard_labels.position
@onready var base_pos_keys = %keyboard_keys.position

func _shake_keyboard():
	var duration = .07
	var radius = 8.
	
	var tw = get_tree().create_tween()
	tw.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	for i in range(0,9):
		var offset = Vector2(randf()-.5,randf()-.5).normalized()
		var final1 = base_pos_labels + offset*radius
		var final2 = base_pos_keys + offset*radius
		tw.tween_property(%keyboard_labels, "position", final1, duration)
		tw.set_parallel(true)
		tw.tween_property(%keyboard_keys, "position", final2, duration)
		tw.set_parallel(false)
	tw.set_parallel(true)
	tw.tween_property(%keyboard_labels, "position", base_pos_labels, duration)
	tw.tween_property(%keyboard_keys, "position", base_pos_keys, duration)
