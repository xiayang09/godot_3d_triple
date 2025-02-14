extends Node3D
@export var player: CharacterBody3D
@onready var map_box: Node3D = $map_box
func _ready():
	#载入地图
	Global.load_map(Global.Map,map_box,Global.Gamemode)
	#载入角色
	Global.change_character(player,Global.Character)
	# 设置场景物体遮罩范围
	var CURVATURE_MESH = get_tree().get_nodes_in_group("CURVATURE_MESH")
	var PLAYER_MESH = get_tree().get_nodes_in_group("PLAYER_MESH")
	for obj in CURVATURE_MESH:
		obj.set_extra_cull_margin(10)
		obj.get_active_material(0).set_shader_parameter("CURVATURE_ACTIVE",true)
	for obj in PLAYER_MESH:
		obj.get_active_material(0).set_shader_parameter("CURVATURE_ACTIVE",true)
	
func _process(delta):
	pass
