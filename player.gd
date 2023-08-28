extends CharacterBody3D

const MOUSE_SENSITIVITY:float = 0.005

const MOVE_SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var current_velocity:Vector3 = Vector3.ZERO

func _physics_process(delta):
	var new_velocity:Vector3 = Vector3.ZERO
	var direction = rotation.y
	var strafe_direction = direction + PI/2
	
	if not is_on_floor():
		new_velocity.y = -(gravity * delta) + velocity.y
	
	if Input.is_action_pressed("move_forward"):
		new_velocity.x += sin(direction) * -1
		new_velocity.z += cos(direction) * -1
	
	if Input.is_action_pressed("move_backward"):
		new_velocity.x += sin(direction)
		new_velocity.z += cos(direction)
	
	if Input.is_action_pressed("strafe_left"):
		new_velocity.x += sin(strafe_direction) * -1
		new_velocity.z += cos(strafe_direction) * -1
	
	if Input.is_action_pressed("strafe_right"):
		new_velocity.x += sin(strafe_direction)
		new_velocity.z += cos(strafe_direction)
	
	new_velocity = new_velocity * Vector3(MOVE_SPEED, 1.0, MOVE_SPEED)
	
	velocity = new_velocity
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -MOUSE_SENSITIVITY)
