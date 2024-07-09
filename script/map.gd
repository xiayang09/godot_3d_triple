extends Node3D
class_name mapx
@export var map_size:= Vector3(60,60,60)
#@onready var mesh_instance_3d_3: MeshInstance3D = $MeshInstance3D3
#const M_TP_QIU = preload('res://asset/character/mat/M_tp_qiu.tres')

func _ready() -> void:
	pass
func changedMat(att:String,toggled:bool):
	print(self)
	for c in self.get_children():
		print(c)
		c.mesh.material.set_shader_parameter(att , toggled)
