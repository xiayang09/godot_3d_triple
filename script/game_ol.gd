extends Node3D
@export var player: CharacterBody3D
@onready var map_box: Node3D = $map_box
func _ready():
		Global.load_map(Global.Map,map_box,Global.Gamemode)
		Global.change_character(player,Global.Character)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
