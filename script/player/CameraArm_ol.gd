extends SpringArm3D
## 默认相机视距（弹簧臂的长度）
@export var distance:float= 30
## 最小相机视距（弹簧臂的长度）
@export var min_distance:float= 10
## 最大相机视距（弹簧臂的长度）
@export var max_distance:float= 40
## 视角缩放速度
@export var distance_speed:float= 40
## 是否开启阻尼
@export var need_damping:bool = true
## 阻尼大小
@export var damping:float = 10
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
	distance += mouse_wheel * distance_speed *delta
	distance = clamp(distance,min_distance,max_distance)
	if need_damping:
		spring_length = lerp(spring_length,distance,delta*damping)
	else :
	#	quaternion = _rotation
		spring_length = distance
func update_mouse_input() -> void: 
	var is_wheel_up = Input.is_action_just_released("mouse_wheel_up")
	var is_wheel_down = Input.is_action_just_released("mouse_wheel_down")
	if is_wheel_up:
		mouse_wheel = MOUSE_WHEEL_STATE.UP
	elif is_wheel_down:
		mouse_wheel = MOUSE_WHEEL_STATE.DOWN
	else :
		mouse_wheel = MOUSE_WHEEL_STATE.NONE
	
