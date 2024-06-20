extends Node2D

func _ready():
	
	Leaderboards.get_data()
	
	$back_button.pressed.connect(func():back())
	
	for each in globals.high_scores :
		var index = globals.high_scores.find(each)
		var score_liner = HBoxContainer.new()
		score_liner.alignment = BoxContainer.ALIGNMENT_CENTER
		score_liner.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		score_liner.name = 'score_liner'
		var best_player = TextureRect.new()
#		best_player.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
#		best_player.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
#		best_player.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var best_time = Label.new()
		best_time.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_time.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_time.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		best_time.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		var best_distance = Label.new()
		best_distance.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_distance.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_distance.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		best_distance.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		var best_error = Label.new()
		best_error.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_error.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_error.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		best_error.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		$scroller/lines.add_child(score_liner)
		$scroller/lines.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		$scroller/lines.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		score_liner.custom_minimum_size = Vector2(1000,90)
		score_liner.add_child(best_player)
		score_liner.add_child(best_time)
		score_liner.add_child(best_distance)
		score_liner.add_child(best_error)
		var cur_animal_id = globals.high_scores[index][0]
		var cur_animal = globals.animals[cur_animal_id]
		var player_sprite = cur_animal["sprite"]
		if cur_animal_id == "elephant" :
			best_player.clip_contents = true
			best_player.size.x = 240
			best_player.custom_minimum_size = Vector2(240,192)
			best_player.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		best_player.texture = load(player_sprite[0])
		best_time.text = str(globals.high_scores[index][1]) + 's'
		best_distance.text = str(globals.high_scores[index][2]) + 'cm'
		best_error.text = str(globals.high_scores[index][3])
		if globals.high_scores[index][3] == 0 :
			best_error.modulate = Color.PALE_GREEN
		elif globals.high_scores[index][3] > 0 and globals.high_scores[index][3] < 60 :
			var hue_error = remap((globals.high_scores[index][3]), 1, 60, 0.12, 0)
			best_error.modulate = Color.from_hsv(hue_error,1,1)
		elif globals.high_scores[index][3] > 60 :
			best_error.modulate = Color.CRIMSON
		var hue_distance = remap((globals.high_scores[index][2]), 0, 30, 0, 0.39)
		best_distance.modulate = Color.from_hsv(hue_distance,1,1)
		var hue_time = remap((globals.high_scores[index][1]), 0, 60, 0.45, 0)
		best_time.modulate = Color.from_hsv(hue_time,1,1)
			
func back():
	get_tree().change_scene_to_file("res://root.tscn")
