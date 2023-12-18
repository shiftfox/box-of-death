extends Node2D

var song: String
var song_player: AudioStreamPlayer2D

func play_sound(asset: String, music = false):
	if music:
		if asset == "stop":
			song_player.stop()
			return
		if asset == song:
			return
		if song_player != null:
			song_player.queue_free()
	
	var stream = load(asset)
	var player = AudioStreamPlayer2D.new()
	player.name = asset.substr(6)
	player.stream = stream
	if not music:
		player.pitch_scale = randf_range(0.5, 2)
	else:
		song = asset
		song_player = player
	add_child(player)
	player.play()
