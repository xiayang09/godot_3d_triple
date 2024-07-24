extends playerx

var direction:Vector3
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var camera_arm = $CameraArm
func _ready() -> void:
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		if state_machine.current_state.name != "Jump" and state_machine.current_state.name != "Fall":
			state_machine.change_state("Fall")
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = Vector3(input_dir.x,0,input_dir.y).normalized()
	if Global.Chatshow:
		direction =Vector3(0,0,0)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor() and !Global.Chatshow:
		state_machine.change_state("Jump")
