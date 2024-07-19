extends Node3D
@onready var animation_player: AnimationPlayer = $door/AnimationPlayer
@onready var light: MeshInstance3D = $door/light
@onready var animation_collision: AnimationPlayer = $door/AnimationCollision
@export var AutomaticDoor :bool = false
const M_DOOR_LIGHT_GREEN = preload("res://asset/item/mat/M_door_light_GREEN.tres")
const M_DOOR_LIGHT_RED = preload("res://asset/item/mat/M_door_light_RED.tres")

var Neardoor = false
var DoorIsOpen = false
var AimIsDone = true
func open():
	animation_player.play("open")
	animation_collision.play("open")
	DoorIsOpen = true
func close():
	animation_player.play("close")
	animation_collision.play("close")
	DoorIsOpen = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Use") and Neardoor and AimIsDone and !AutomaticDoor:
		if DoorIsOpen:
			close()
		else :
			open()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Neardoor = true
		#light.get_active_material(0).emission = "00ff11" 
		light.set_surface_override_material(0,M_DOOR_LIGHT_GREEN)
		if AutomaticDoor:
			open()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == Global.player:
		#light.get_active_material(0).emission = "ff0004"
		light.set_surface_override_material(0,M_DOOR_LIGHT_RED)
		if DoorIsOpen:
			close()
		Neardoor = false

func Aimstart():
	AimIsDone = false
func Aimend():
	AimIsDone = true
