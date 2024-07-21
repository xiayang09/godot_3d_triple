extends Node3D
@onready var animation_player: AnimationPlayer = $door/AnimationPlayer
@onready var animation_collision: AnimationPlayer = $door/AnimationCollision
@export var AutomaticDoor :bool = false
@onready var door_light: Node3D = $door/door_light


var Neardoor = false
var DoorIsOpen = false
var AimIsDone = true
func _ready() -> void:
	pass
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

		door_light.get_node("door_light_off").visible = false
		door_light.get_node("door_light_on").visible = true
		if AutomaticDoor:
			open()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == Global.player:
		door_light.get_node("door_light_on").visible = false
		door_light.get_node("door_light_off").visible = true
		if DoorIsOpen:
			close()
		Neardoor = false

func Aimstart():
	AimIsDone = false
func Aimend():
	AimIsDone = true
