extends stateBase
@export var player: playerx 

func enter() ->void:
	super.enter()
	print("奔跑状态")
	player.character_skin.is_moving = true
	#player.audio_stream_player.playing = true
func physics_process_update(delta:float)->void:
	super.physics_process_update(delta)
	if player.direction:
		player.velocity.x = player.direction.x * player.SPEED
		player.velocity.z = player.direction.z * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)
	if abs(player.velocity.x) + abs(player.velocity.z) >0.1:
		var characterDir = Vector2(-player.velocity.z,-player.velocity.x)
		var target_quaternion:Quaternion=Quaternion.from_euler(Vector3(0,characterDir.angle(),0))
		player.character_rotation_root.quaternion = player.character_rotation_root.quaternion.slerp(target_quaternion,delta*8)
	if player.direction == Vector3.ZERO:
		state_machine.change_state("Idle")
