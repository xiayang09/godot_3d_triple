extends playerx
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var mouse_click_ring = $"../3DUI/Mouse_click_ring"
@onready var main_ui: Control = $"../Main_UI"
var direction:Vector3
const SPEED = 3
var JumpMode = false
const JUMP_VELOCITY = 4.5
var mouse_click_target = Vector3()

func _ready():
	Global.overlook_mode = main_ui.get_node("PauseScreen/box/set/moveMethod").selected
	JumpMode = main_ui.get_node("PauseScreen/box/set/jump").button_pressed
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		if state_machine.current_state.name != "Jump" and state_machine.current_state.name != "Fall":
			state_machine.change_state("Fall")
	if Global.overlook_mode == Global.mouseleft or Global.overlook_mode == Global.mouseright:
		var direction_3d = (navigation_agent_3d.get_next_path_position() - global_position).normalized()
		if abs(direction_3d.x)>0.05 or abs(direction_3d.z)>0.05:
			direction = direction_3d
		else :
			direction = Vector3.ZERO
			mouse_click_ring.visible = false
	elif Global.overlook_mode ==Global.wasd:	
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		direction = Vector3(input_dir.x,0,input_dir.y)

	move_and_slide()
func mouse_move():
	mouse_click_target = SrreenPortinToRay()
	navigation_agent_3d.target_position = mouse_click_target
	mouse_click_ring.position = mouse_click_target
	mouse_click_ring.visible = true
	self.get_node("click").playing = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor() and JumpMode:
		state_machine.change_state("Jump")
	if event.is_action_pressed("mouse_click_left"):
		if Global.overlook_mode ==0:
			if !Global.ButtonEnter:
				mouse_move()
	if event.is_action_pressed("mouse_click_right"):
		if Global.overlook_mode ==1:
			if !Global.ButtonEnter:
				mouse_move()
func SrreenPortinToRay():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayOrigin = camera_3d.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera_3d.project_ray_normal(mousePos) *2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var rayArray = spaceState.intersect_ray(query)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
func _on_jump_toggled(toggled_on: bool) -> void:
	JumpMode= toggled_on
