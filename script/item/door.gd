extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var light: MeshInstance3D = $light

var Neardoor = false
var DoorIsOpen = false
var AimIsDone = true
func open():
	animation_player.play("open")
func close():
	animation_player.play("close")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Use") and Neardoor and AimIsDone:
		if DoorIsOpen:
			close()
			DoorIsOpen = false
		else :
			open()
			timer.start()
			DoorIsOpen = true
			
func _on_timer_timeout() -> void:
	if DoorIsOpen:
		close()
		DoorIsOpen = false
		timer.stop()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Neardoor = true
		light.get_active_material(0).emission = "00ff11" 
		print(Neardoor)
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == Global.player:
		light.get_active_material(0).emission = "ff0004"
		Neardoor = false
		print(Neardoor)	

func Aimstart():
	AimIsDone = false
func Aimend():
	AimIsDone = true
