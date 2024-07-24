extends CharacterBody3D
## 玩家
class_name playerx

@onready var character_rotation_root: Node3D = $characterRotationRoot
@export var character_skin: characterSkin
@onready var state_machine: StateMachine = $StateMachine
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
func  _physics_process(delta: float) -> void:
	pass
