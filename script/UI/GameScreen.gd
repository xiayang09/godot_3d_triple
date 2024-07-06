extends Control
@onready var pause_screen: Control = $"../PauseScreen"
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		PauseGame()

func PauseGame() -> void:
	get_tree().paused = true
	self.visible = false
	pause_screen.visible = true


func _on_esc_pressed() -> void:
	PauseGame()
