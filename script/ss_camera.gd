extends Camera3D
@export var player:playerx
var oldpos:Vector3
@export var camera_smosth = 2
func _ready() -> void:
	oldpos = self.position

func _physics_process(delta: float) -> void:
	var playerpos = player.position
	var target = Vector3(playerpos.x,playerpos.y+oldpos.y,oldpos.z)
	self.position = self.position.slerp(target,delta*camera_smosth)
