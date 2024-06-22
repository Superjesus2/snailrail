extends Control


func _ready():
	
	$sub_button.pressed.connect(func():submit())


func submit():
	if $namer.text != '':
		self.visible = false
	
