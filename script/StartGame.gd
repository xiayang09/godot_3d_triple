extends Control
@onready var character_btn = $character_box.get_children()
@onready var GameMode_btn = $GameMode_box.get_children()

func btn_tools(btn,i:int):
	for obj in btn:
		obj.button_pressed = false
	btn[i].button_pressed = true

func start_game_overlook():
	get_tree().call_deferred("change_scene_to_file","res://game/game_overlook.tscn")

func _on_character_1_pressed():
	btn_tools(character_btn,0)
	Global.character = "Suzanne_001"

func _on_character_2_pressed():
	btn_tools(character_btn,1)
	Global.character = "Ball_001"

func _on_character_3_pressed():
	btn_tools(character_btn,2)
	Global.character = "Teapot"


func _on_button_pressed():
	start_game_overlook()
	#print(character)
func _on_button_2_pressed():
	get_tree().quit()


func _on_game_mode_1_pressed() -> void:
	btn_tools(GameMode_btn,0)
	Global.gamemode = Global.OverLook


func _on_game_mode_2_pressed() -> void:
	btn_tools(GameMode_btn,1)
	Global.gamemode = Global.TridPerson


func _on_game_mode_3_pressed() -> void:
	btn_tools(GameMode_btn,2)
	Global.gamemode = Global.SideScrolling
