extends Node3D
@export var player: CharacterBody3D
@onready var map_box: Node3D = $map_box
func _ready():
	#载入地图
	Global.load_map(Global.Map,map_box,Global.Gamemode)
	#载入角色
	Global.change_character(player,Global.Character)
	# 设置场景物体遮罩范围
func _process(delta):
	pass
