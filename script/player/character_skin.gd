extends Node3D
class_name characterSkin
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine:AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var is_moving:bool= false:
	set(value):
		is_moving = value
		if is_moving:
			state_machine.travel("Walk")
		else:
			state_machine.travel("Idle")
func jump() ->void:
	state_machine.travel("Jump")

func fall() ->void:
	state_machine.travel("Fall")
