extends Node3D


func _ready():
	var palyer = $Player
	var map_box = $map_box
	Global.load_map(Global.map,map_box,0)
	Global.change_character(palyer,Global.character)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
