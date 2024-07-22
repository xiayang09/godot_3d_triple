extends stateBase
@export var player: playerx 
func enter() ->void:
	super.enter()
	print("跳跃状态")
	player.velocity.y = player.JUMP_VELOCITY
	player.character_skin.jump()
	
func physics_process_update(delta:float)->void:
	super.physics_process_update(delta)
	if player.is_on_floor():
		state_machine.change_state("Idle")
	if player.velocity.y <0:
		state_machine.change_state("Fall")
	if player.direction!=0:
		player.velocity.x = player.direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	if player.velocity.x!=0:
		var characterDir = Vector2(player.velocity.x,player.velocity.z)
		#var target_quaternion:Quaternion=Quaternion.from_euler(Vector3(0,characterDir.angle(),0))
		player.character_rotation_root.rotation =player.character_rotation_root.rotation.slerp(Vector3(0,-characterDir.angle(),0),delta*player.TURN_VATE)
