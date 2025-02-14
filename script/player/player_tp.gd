extends playerx

var direction:Vector3
const SPEED = 5.0
const JUMP_VELOCITY = 5.0
@onready var camera_arm = $CameraArm
func _ready() -> void:
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		if state_machine.current_state.name != "Jump" and state_machine.current_state.name != "Fall":
			state_machine.change_state("Fall")
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var _rotation:Quaternion = Quaternion.from_euler(Vector3(0,camera_arm.transform.basis.get_euler().y,0))
	direction = (_rotation * Vector3(input_dir.x,0,input_dir.y)).normalized()
	var playerpos = self.position
	if abs(playerpos.x) > Global.Map_size.x/2:
		self.position.x = -playerpos.x
	if abs(playerpos.z) > Global.Map_size.z/2:
		self.position.z = -playerpos.z
	if Global.Chatshow:
		direction = Vector3(0,0,0)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor() and !Global.Chatshow:
		state_machine.change_state("Jump")
		#character_skin.Call("test")
