extends Node

var which_key_is_pressed = []
var keys = []
var going_right = true
var starting = true
var elapsed_time = 0

var is_slowed = false
var is_snared = false
var vitesse = 0
var backg_pos_x = 1200
var idle_duration = 0

const key_names_1 = ["E","R","T","Y","U","I"]
const key_names_2 = ["S","D","F","G","H","J","K","L"]
const key_names_3 = ["V","B","N"]

const finish_line_pos_x = -550
const max_idle_duration = 1.2
const vitesse_max = 128
const vitesse_min = 0


func _ready():

	for i in range(0,8):
		var key_label = Button.new()
		keys.append(key_label)
		$keyboard_keys.add_child(key_label)
		key_label.text = key_names_2[i]
		key_label.name = "label_" + key_names_2[i]
		key_label.toggle_mode = true
		key_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		# AJOUTER DES SPRITES AUX BOUTONS -> EVITER LA BOUCLE ?
		# INSERER CETTE BOUCLE DANS start_snail ?

	start_snail()
	start_other_candidates()

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

func _input(event):
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
#	if Input.is_physical_key_pressed(KEY_D):
#		if going_right == true:
#			if label_D.button_pressed == false and label_S.button_pressed == true:
#				print("D, go to F")
#			else:
#				print('fail')
#		else:
#			if label_D.button_pressed == false and label_F.button_pressed == true:
#				print("D, go to S")
#			else:
#				print('fail')
#	if Input.is_physical_key_pressed(KEY_F):
#	if Input.is_physical_key_pressed(KEY_G):
#	if Input.is_physical_key_pressed(KEY_H):
#	if Input.is_physical_key_pressed(KEY_J):
#	if Input.is_physical_key_pressed(KEY_K):
#	if Input.is_physical_key_pressed(KEY_L):
