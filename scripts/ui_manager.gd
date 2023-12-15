extends CanvasLayer

@onready var finishScreen = $FinishScreen
@onready var pauseScreen = $PauseScreen
var paused = false
var success = false

func _ready():
	AudioManager.play_sound("res://audio/8-bit-game.mp3", true)

func _input(_event):
	if Input.is_action_just_pressed("ui_pause"):
		toggle_pause()

func toggle_pause():
	paused = not paused
	get_tree().paused = paused

	if paused:
		pauseScreen.show()
	else:
		pauseScreen.hide()

func finish(success: bool):
	paused = true
	get_tree().paused = true
	finishScreen.show()
	self.success = success
	
	if success:
		$FinishScreen/Restart/Label.text = "Continue"

	var status = finishScreen.get_node("Status")
	status.text = "Successful" if success else "Unsuccessful"
	status.modulate = Color.LIME_GREEN if success else Color.ORANGE_RED

# Button Signals #

func main_menu():
	toggle_pause()
	SceneManager.change_scene("res://scenes/menus.tscn")

func restart():
	toggle_pause()
	if not success:
		SceneManager.reload_scene()
	else:
		SceneManager.change_scene("res://scenes/level_%d.tscn" % (int(get_tree().current_scene.name.substr(5)) + 1))

func quit():
	get_tree().quit()
