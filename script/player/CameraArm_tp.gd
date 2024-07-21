extends SpringArm3D
## 控制X轴上的旋转速度
@export var x_speed:float = 5
## 控制Y轴上的旋转速度
@export var y_speed:float = 5
## 最小角度值（相机与平面的夹角）
@export_range(10, 80) var x_min_limit_angle:float = 0
## 最大角度值（相机与平面的夹角）
@export_range(10, 80)  var x_max_limit_angle:float = 80
## 默认相机视距（弹簧臂的长度）
@export var distance:float= 5
## 最小相机视距（弹簧臂的长度）
@export var min_distance:float= 1
## 最大相机视距（弹簧臂的长度）
@export var max_distance:float= 10
## 视角缩放速度
@export var distance_speed:float= 10
## 是否开启阻尼
@export var need_damping:bool = true
## 阻尼大小
@export var damping:float = 10
## 鼠标邮件是否按下
var mouse_right_press:bool = false
## 鼠标滑动的枚举值
enum MOUSE_WHEEL_STATE{
	NONE=0,
	UP=-1,
	DOWN=1,
}
var mouse_wheel:MOUSE_WHEEL_STATE = MOUSE_WHEEL_STATE.NONE
var x:float = 0 
var y:float = 0

func _ready() -> void:
	x = transform.basis.get_euler().x
	y = transform.basis.get_euler().y

func _process(delta: float) -> void:
	update_mouse_input()
	var _rotation:Quaternion = Quaternion.from_euler(Vector3(x,y,0))
	distance += mouse_wheel * distance_speed *delta
	distance = clamp(distance,min_distance,max_distance)
	if need_damping:
		quaternion = quaternion.slerp(_rotation,delta *damping)
		spring_length = lerp(spring_length,distance,delta*damping)
	else :
		quaternion = _rotation
		spring_length = distance
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_right_press:
		x = x + -event.relative.y * x_speed * 0.001
		y = y + -event.relative.x * y_speed * 0.001
		var x_min_limit = x_min_limit_angle/180*PI
		var x_max_limit = x_max_limit_angle/180*PI
		x = -clamp(-x,x_min_limit,x_max_limit)
func update_mouse_input() -> void: 
	mouse_right_press = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	var is_wheel_up = Input.is_action_just_released("mouse_wheel_up")
	var is_wheel_down = Input.is_action_just_released("mouse_wheel_down")
	if is_wheel_up:
		mouse_wheel = MOUSE_WHEEL_STATE.UP
	elif is_wheel_down:
		mouse_wheel = MOUSE_WHEEL_STATE.DOWN
	else :
		mouse_wheel = MOUSE_WHEEL_STATE.NONE
	
