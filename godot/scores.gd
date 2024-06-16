extends Node2D



func _ready():
	
	$back_button.pressed.connect(func():back())
	
	for each in globals.high_scores :
		var index = globals.high_scores.find(each)
		print(globals.high_scores[index])
		var score_liner = HBoxContainer.new()
		score_liner.alignment = BoxContainer.ALIGNMENT_CENTER
		score_liner.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		var best_player = Label.new()
		best_player.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_player.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_player.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var best_time = Label.new()
		best_time.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_time.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_time.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var best_distance = Label.new()
		best_distance.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_distance.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_distance.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var best_error = Label.new()
		best_error.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_error.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		best_error.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		$scroller/lines.add_child(score_liner)
		$scroller/lines.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		$scroller/lines.size_flags_vertical = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND_FILL
		score_liner.custom_minimum_size = Vector2(1000,90)
		score_liner.add_child(best_player)
		score_liner.add_child(best_time)
		score_liner.add_child(best_distance)
		score_liner.add_child(best_error)
		best_player.text = str(globals.high_scores[index][0])
		best_time.text = str(globals.high_scores[index][1])
		best_distance.text = str(globals.high_scores[index][2])
		best_error.text = str(globals.high_scores[index][3])

func back():
	get_tree().change_scene_to_file("res://root.tscn")
