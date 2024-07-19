extends playerx
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var mouse_click_ring = $"../3DUI/Mouse_click_ring"
@export var main_ui: Control
var direction:Vector3
const SPEED = 3
const JUMP_VELOCITY = 4.5
var mouse_click_target = Vector3()
enum MODE{
	MOUSELEFT,MOUSERIGHT,WASD
}
@onready var Overlook_mode:= MODE.WASD

func _ready():
	Overlook_mode = main_ui.get_node("PauseScreen/box/set/moveMethod").selected
	#print(character_skin)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		if state_machine.current_state.name != "Jump" and state_machine.current_state.name != "Fall":
			state_machine.change_state("Fall")
	if Overlook_mode == MODE.MOUSELEFT or Overlook_mode == MODE.MOUSERIGHT:
		var direction_3d = (navigation_agent_3d.get_next_path_position() - global_position).normalized()
		if abs(direction_3d.x)>0.05 or abs(direction_3d.z)>0.05:
			direction = direction_3d
		else :
			direction = Vector3.ZERO
			mouse_click_ring.visible = false
	elif Overlook_mode ==MODE.WASD:	
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		direction = Vector3(input_dir.x,0,input_dir.y)
		if Global.Chatshow:
			direction = Vector3(0,0,0)

	move_and_slide()
func mouse_move():
	mouse_click_target = SrreenPortinToRay()
	navigation_agent_3d.target_position = mouse_click_target
	mouse_click_ring.position = mouse_click_target
	mouse_click_ring.visible = true
	self.get_node("click").playing = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click_left"):
		if Overlook_mode == MODE.MOUSELEFT:
			if !Global.ButtonEnter:
				mouse_move()
	if event.is_action_pressed("mouse_click_right"):
		if Overlook_mode ==MODE.MOUSERIGHT:
			if !Global.ButtonEnter:
				mouse_move()
func SrreenPortinToRay():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayOrigin = camera_arm.get_node("Camera3D").project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera_arm.get_node("Camera3D").project_ray_normal(mousePos) *2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var rayArray = spaceState.intersect_ray(query)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
