extends Control

func _ready():
	$sub_button.pressed.connect(func():submit())
	$nosub_button.pressed.connect(func():no_sub())

func submit():
	if $name_in.text != '':
		self.visible = false
		globals.player_name = $name_in.text
		print(globals.player_name)
		Leaderboards.submitting = true
		Leaderboards.ready_to_send.emit()

func no_sub():
	self.visible = false
	Leaderboards.submitting = false
	Leaderboards.dont_send.emit()
