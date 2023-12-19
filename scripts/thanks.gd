extends Node2D

func _ready():
	AudioManager.play_sound("res://audio/menus.mp3", true)

func menus():
	SceneManager.change_scene("res://scenes/menus.tscn")

func _on_player_died():
	$"CanvasLayer/YouWon".text = ">:)"
