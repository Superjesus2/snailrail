extends Control

func _ready():
	
	$sub_button.pressed.connect(func():submit())

func submit():
	if $name_in.text != '':
		self.visible = false
		globals.player_name = $name_in.text
		Leaderboards.ready_to_send.emit()
