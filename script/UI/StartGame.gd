extends Control
@onready var character_btn = $character_box
@onready var GameMode_btn = $GameMode_box
@onready var sub_viewport: SubViewport = $SubViewport
@onready var mapbox: GridContainer = $mapbox
@onready var tp_map_box: GridContainer = $mapbox/tp_map_box
@onready var ss_map_box: GridContainer = $mapbox/ss_map_box
@onready var ac_map_box: GridContainer = $mapbox/ac_map_box
@onready var ol_map_box: GridContainer = $mapbox/ol_map_box


func _ready() -> void:
	#var character3Dtex = $SubViewport.get_texture()
	#$character3D.texture = character3Dtex
	Global.Gamemode = Global.OverLook
	Global.Map = "ol_map_1"
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
	
func start_game_AnimalCrossing():
	map_sel(ac_map_box)
	get_tree().call_deferred("change_scene_to_file","res://game/game_AnimalCrossing.tscn")


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
		return
	if Global.Gamemode == Global.AnimalCrossing:
		start_game_AnimalCrossing()
		return
func _on_button_2_pressed():
	get_tree().quit()

func mapq():
	var mapuic = mapbox.get_children()
	for obj in mapuic:
		obj.visible = false
	print(Global.Gamemode)
	mapuic[Global.Gamemode].visible = true

func _on_game_mode_1_pressed() -> void:
	btn_tools(GameMode_btn,0)
	Global.Gamemode = Global.OverLook
	mapq()

func _on_game_mode_2_pressed() -> void:
	btn_tools(GameMode_btn,1)
	Global.Gamemode = Global.TridPerson
	mapq()

func _on_game_mode_3_pressed() -> void:
	btn_tools(GameMode_btn,2)
	Global.Gamemode = Global.SideScrolling
	mapq()

func _on_game_mode_4_pressed() -> void:
	btn_tools(GameMode_btn,3)
	Global.Gamemode = Global.AnimalCrossing
	mapq()
func _on_map_1_pressed() -> void:
	btn_tools(tp_map_box,0)
func _on_map_2_pressed() -> void:
	btn_tools(tp_map_box,1)

