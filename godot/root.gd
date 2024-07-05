extends CanvasItem

var cur_animal_id = globals.players[globals.player_selected]
var cur_animal = globals.animals[cur_animal_id]
var player_sprite = cur_animal["sprite"]

func _ready():
	if globals.just_started :
		globals.just_started = false
		get_tree().change_scene_to_file("res://disclaimer.tscn")
	
	$play_button.pressed.connect(func():play())
	$player_button.pressed.connect(func():player_select())
	$scores_button.pressed.connect(func():high_scores())
	$exit_button.pressed.connect(func():exit())
	$player.texture = load(player_sprite[0])
	
#	if globals.first_try :
#		$scores_button.visible = false

func high_scores():
	get_tree().change_scene_to_file("res://scores.tscn")

func play():
#	var game = preload("res://game.tscn").instantiate()
#	get_tree().get_root().add_child(game)
	get_tree().change_scene_to_file("res://game.tscn")
func player_select():
#	var selecter = preload("res://player_select.tscn").instantiate()
#	get_tree().get_root().add_child(selecter)
	get_tree().change_scene_to_file("res://player_select.tscn")
func exit():
	get_tree().quit()
	
