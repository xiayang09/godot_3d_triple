extends Node3D
## 基础状态
class_name stateBase

var state_machine:StateMachine

func enter() ->void:
	pass

func exit() ->void:
	pass

func process_update(_delta:float)->void:
	pass

func physics_process_update(_delta:float)->void:
	pass
