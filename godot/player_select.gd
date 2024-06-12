extends Node2D

var cur_animal_id = globals.players[globals.player_selected]
var cur_animal = globals.animals[cur_animal_id]
var player_sprite = cur_animal["sprite"]

func _ready():
	$back_button.pressed.connect(func():back())
	$left_select.pressed.connect(func():left())
	$right_select.pressed.connect(func():right())

func back():
	get_tree().change_scene_to_file("res://root.tscn")
func left():
	if globals.player_selected > 0:
		globals.player_selected -= 1
	else:
		globals.player_selected = (globals.players.size() - 1)
	
	cur_animal_id = globals.players[globals.player_selected]
	cur_animal = globals.animals[cur_animal_id]
	player_sprite = cur_animal["sprite"]
	$player_pic.texture = load(player_sprite)
	
func right():
	if globals.player_selected < (globals.players.size() - 1):
		globals.player_selected += 1
	else:
		globals.player_selected = 0
		
	cur_animal_id = globals.players[globals.player_selected]
	cur_animal = globals.animals[cur_animal_id]
	player_sprite = cur_animal["sprite"]
	$player_pic.texture = load(player_sprite)
