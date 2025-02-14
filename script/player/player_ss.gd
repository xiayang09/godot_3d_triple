extends playerx

var direction : float
const SPEED = 5.0
const JUMP_VELOCITY = 10
const TURN_VATE = 16
func _ready() -> void:
	gravity = 16
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		if state_machine.current_state.name != "Jump" and state_machine.current_state.name != "Fall":
			state_machine.change_state("Fall")
	#var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = Input.get_axis("move_left","move_right")
	#var _rotation:Quaternion = Quaternion.from_euler(Vector3(0,camera_arm.transform.basis.get_euler().y,0))
	#direction = Vector3(input_dir.x,0,input_dir.y).normalized()
	#if Global.Chatshow:
		#direction = 0
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor() and !Global.Chatshow:
		state_machine.change_state("Jump")
