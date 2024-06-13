extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for score in globals.best_scores :
		var score_line = HBoxContainer.new()
		$scroller.add_child(score_line)
