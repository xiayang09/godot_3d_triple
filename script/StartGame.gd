extends Control
@onready var character_btn = $character_box
@onready var GameMode_btn = $GameMode_box
@onready var tp_map_box = $tp_map_box
@onready var ol_map_box: GridContainer = $ol_map_box
@onready var sub_viewport: SubViewport = $SubViewport
@onready var ss_map_box: GridContainer = $ss_map_box

func _ready() -> void:
	var character3Dtex = $SubViewport.get_texture()
	$character3D.texture = character3Dtex
	Global.Gamemode = Global.OverLook
	Global.Map = ol_map_box.get_children()[0].map_name
	Global.Character = "Suzanne_001"
	#print(Global.Map)
func btn_tools(btn,i:int):
	var btn_c = btn.get_children()
	for obj in btn_c:
		obj.button_pressed = false
	btn_c[i].button_pressed = true
func map_sel(obj):
	var c = obj.get_children()
	for a in c:
		if a.button_pressed == true:
			Global.Map = a.map_name
func changed_3dmodel(obj:int):
	var cbox = sub_viewport.get_node("Node3D").get_children()
	for i in cbox:
		i.visible = false
	cbox[obj].visible = true

func start_game_overlook():
	map_sel(ol_map_box)
	get_tree().call_deferred("change_scene_to_file","res://game/game_overlook.tscn")
func start_game_thirdperson():
	map_sel(tp_map_box)
	get_tree().call_deferred("change_scene_to_file","res://game/game_thirdperson.tscn")
func start_game_sidescrolling():
	map_sel(ss_map_box)
	get_tree().call_deferred("change_scene_to_file","res://game/game_sidescrolling.tscn")
func _on_character_1_pressed():
	btn_tools(character_btn,0)
	Global.Character = "Suzanne_001"
	changed_3dmodel(0)

func _on_character_2_pressed():
	btn_tools(character_btn,1)
	Global.Character = "Ball_001"
	changed_3dmodel(1)

func _on_character_3_pressed():
	btn_tools(character_btn,2)
	Global.Character = "Teapot_001"
	changed_3dmodel(2)


func _on_button_pressed():
	if Global.Gamemode == Global.OverLook:
		start_game_overlook()
		return
	if Global.Gamemode == Global.TridPerson:
		start_game_thirdperson()
		return
	if Global.Gamemode == Global.SideScrolling:
		start_game_sidescrolling()
	#print(character)
func _on_button_2_pressed():
	get_tree().quit()


func _on_game_mode_1_pressed() -> void:
	print("aaa")
	btn_tools(GameMode_btn,0)
	Global.Gamemode = Global.OverLook
	tp_map_box.visible = false
	ol_map_box.visible = true
	ss_map_box.visible = false

func _on_game_mode_2_pressed() -> void:
	print("aaa")
	btn_tools(GameMode_btn,1)
	Global.Gamemode = Global.TridPerson
	tp_map_box.visible = true
	ol_map_box.visible = false
	ss_map_box.visible = false

func _on_game_mode_3_pressed() -> void:
	print("aaa")
	btn_tools(GameMode_btn,2)
	Global.Gamemode = Global.SideScrolling
	tp_map_box.visible = false
	ol_map_box.visible = false
	ss_map_box.visible = true

func _on_map_1_pressed() -> void:
	btn_tools(tp_map_box,0)


func _on_map_2_pressed() -> void:
	btn_tools(tp_map_box,1)



