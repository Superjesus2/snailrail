extends CanvasItem

func _ready():
	$play_button.pressed.connect(func():play())
	$player_button.pressed.connect(func():player_select())
	$exit_button.pressed.connect(func():exit())

func _process(delta):
	pass

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
