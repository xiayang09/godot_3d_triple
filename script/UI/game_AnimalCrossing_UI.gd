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
func changeCurvature(value:float):
	var CURVATURE_MESH = get_tree().get_nodes_in_group("CURVATURE_MESH")
	var PLAYER_MESH = get_tree().get_nodes_in_group("PLAYER_MESH")
	for obj in CURVATURE_MESH:
		obj.get_active_material(0).set_shader_parameter("SPRITE_POS_Y",value/2000*-1)
	for obj in PLAYER_MESH:
		obj.get_active_material(0).set_shader_parameter("SPRITE_POS_Y",value/2000*-1)	
func _on_esc_pressed() -> void:
	PauseGame()
func _on_continue_pressed() -> void:
	continueGame()
func _on_exit_pressed() -> void:
	continueGame()
	get_tree().call_deferred("change_scene_to_file","res://game/start_game.tscn")
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
	var CURVATURE_MESH = get_tree().get_nodes_in_group("CURVATURE_MESH")
	var PLAYER_MESH = get_tree().get_nodes_in_group("PLAYER_MESH")
	for obj in CURVATURE_MESH:
		obj.get_active_material(0).set_shader_parameter("CURVATURE_ACTIVE",toggled_on)
	for obj in PLAYER_MESH:
		obj.get_active_material(0).set_shader_parameter("CURVATURE_ACTIVE",toggled_on)

func _on_h_slider_value_changed(value: float) -> void:
	changeCurvature(value)


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	var tween =get_tree().create_tween().set_parallel(true)
	var cam = player.get_node("CameraArm")
	var camspeed:float = 0.5
	if !toggled_on:
		var x = deg_to_rad(-35)
		tween.tween_property(cam,"rotation",Vector3(x,0,0),camspeed)
		tween.tween_property(cam,"spring_length",5,camspeed)
	else :
		var x = deg_to_rad(-55)
		tween.tween_property(cam,"rotation",Vector3(x,0,0),camspeed)
		tween.tween_property(cam,"spring_length",7,camspeed)
