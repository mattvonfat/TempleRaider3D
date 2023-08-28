extends Node3D

@onready var camera_node:Camera3D = $Camera3D

const ZOOM_MAX_DISTANCE:float = 30.0
const ZOOM_MIN_DISTANCE:float = 10.0

var ZOOM_SPEED:float = 1.0
var ROTATION_SPEED:float = 0.01

var target


func _physics_process(_delta) -> void:
	# if there is a target selected then make sure the camera is following it
	if target != null:
		position = target.position

func set_target(new_target) -> void:
	# updates the object that the camera will follow
	target = new_target

func zoom_in() -> void:
	# moves the camera towards the parent node
	var direction = camera_node.position.direction_to(Vector3.ZERO)
	var new_camera_position = camera_node.position + (direction * ZOOM_SPEED)
	
	if new_camera_position.distance_to(Vector3.ZERO) > ZOOM_MIN_DISTANCE:
		camera_node.position = new_camera_position
	#camera_node.position.lerp(camera_node.position + (direction * ZOOM_SPEED), 0.7)

func zoom_out() -> void:
	# moves the camera away from the parent node
	var direction = camera_node.position.direction_to(Vector3(0.0,0.0,0.0))
	var new_camera_position = camera_node.position - (direction * ZOOM_SPEED)
	
	if new_camera_position.distance_to(Vector3.ZERO) < ZOOM_MAX_DISTANCE:
		camera_node.position = new_camera_position

func rotate_camera(rel:Vector2, vel:Vector2) -> void:
	# is the mouse movement is greater in the x-axis then rotate around the target, if it's greater in the
	# y-axis then move up and down
	if abs(rel.x) > abs(rel.y):
		rotate_y(rel.x * -ROTATION_SPEED)
	else:
		rotate_object_local(Vector3.RIGHT, rel.y * -ROTATION_SPEED)
