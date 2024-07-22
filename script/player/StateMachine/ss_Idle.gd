extends stateBase
@export var player: playerx 

func enter() ->void:
	super.enter()
	print("待机状态")
	player.character_skin.is_moving = false
	#player.audio_stream_player.playing = false
func physics_process_update(delta:float)->void:
	super.physics_process_update(delta)
	if player.direction!=0:
		state_machine.change_state("Run")
