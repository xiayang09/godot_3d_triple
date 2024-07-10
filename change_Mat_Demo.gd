extends Node3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
var mat = 1
func _ready() -> void:
	#var mat = mesh_instance_3d.get_surface_override_material_count()
	#print(mat)
	#print(aa)
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	mesh_instance_3d.get_active_material(0).set_shader_parameter("CURVATURE_ACTIVE",toggled_on)


func _on_h_slider_value_changed(value: float) -> void:
	mesh_instance_3d.get_active_material(0).set_shader_parameter("SPRITE_POS_Y",value/1000*-1)


func _on_color_picker_button_color_changed(color: Color) -> void:
	mesh_instance_3d.get_active_material(0).set_shader_parameter("albedo",color)
