extends Node2D


func _input(event) :
	if event is InputEventKey:
		if event.is_pressed() and not event.is_echo() :
			get_tree().change_scene_to_file("res://root.tscn")
			AudioPlayer.play_music()
