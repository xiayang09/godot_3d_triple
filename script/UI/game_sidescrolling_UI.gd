extends Control
@export var player: playerx
@export var Mapbox: Node3D
@onready var option_button: OptionButton = $PauseScreen/box/set/OptionButton

func _ready() -> void:
	if Global.Character == "Suzanne_001":
		option_button.selected = 0
	if Global.Character == "Ball_001":
		option_button.selected = 1
	if Global.Character == "Teapot_001":
		option_button.selected = 2	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		if Global.GamePauseState:
			continueGame()
		else:
			PauseGame()
func _on_esc_pressed() -> void:
	PauseGame()
func _on_continue_pressed() -> void:
	continueGame()
func _on_exit_pressed() -> void:
	continueGame()
	get_tree().call_deferred("change_scene_to_file","res://game/UI/start_game.tscn")
func continueGame() ->void:
	get_tree().paused = false
	self.get_node("GameScreen").visible = true
	self.get_node("PauseScreen").visible = false
	Global.GamePauseState = false
func PauseGame() -> void:
	self.get_node("GameScreen").visible = false
	self.get_node("PauseScreen").visible = true
	Global.GamePauseState = true
	get_tree().paused = true
func _on_music_value_changed(value: float) -> void:
	Global.set_volume(Global.Bus.Music ,value*0.002)
func _on_sfx_value_changed(value: float) -> void:
	Global.set_volume(Global.Bus.SFX ,value*0.002)

func _on_option_button_item_selected(index):
	if index == 0:
		Global.change_character(player,"Suzanne_001")
	elif index == 1:
		Global.change_character(player,"Ball_001")
	elif index == 2:
		Global.change_character(player,"Teapot_001")
	else:
		pass

func _on_esc_mouse_entered():
	Global.ButtonEnter = true

func _on_esc_mouse_exited():
	Global.ButtonEnter = false



func _on_check_button_toggled(toggled_on: bool) -> void:
	pass
