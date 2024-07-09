extends Node3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	#var mat = mesh_instance_3d.get_surface_override_material_count()
	#print(mat)
	
	#print(aa)
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	mesh_instance_3d.get_active_material(0).set_shader_parameter("CURVATURE",toggled_on)


func _on_h_slider_value_changed(value: float) -> void:
	mesh_instance_3d.get_active_material(0).set_shader_parameter("SPRITE_POS_Y",value/10000*-1)
