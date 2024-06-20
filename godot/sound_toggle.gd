extends TextureButton

#
#var sound_bus = AudioServer.get_bus_index('Master')
#
#func _on_pressed():
#	AudioServer.set_bus_mute(sound_bus, not AudioServer.is_bus_mute(sound_bus))

#func _on_pressed():
#	if self.toggled :
#		AudioPlayer.stop_music()
#	else :
#		AudioPlayer.play_music()

func _toggled(button_pressed):
	if button_pressed :
		AudioPlayer.stop_music()
	else :
		AudioPlayer.play_music()
