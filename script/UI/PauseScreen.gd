extends Control
@onready var move_method: OptionButton = $VBoxContainer/HBoxContainer/moveMethod
@onready var pause_screen: Control = $"."
@onready var game_screen: Control = $"../GameScreen"
@onready var player = $"../Player"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		continueGame()

func _on_continue_pressed() -> void:
	continueGame()


func _on_exit_pressed() -> void:
	get_tree().quit()

func continueGame() ->void:
	get_tree().paused = false
	game_screen.visible = true
	pause_screen.visible = false
	if player.mode1==0:
		game_screen.get_node("HBoxContainer/Label2").text = "鼠标左键"
	if player.mode1==1:
		game_screen.get_node("HBoxContainer/Label2").text = "鼠标右键"
	if player.mode1==2:
		game_screen.get_node("HBoxContainer/Label2").text = "W A S D"
