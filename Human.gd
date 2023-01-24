extends KinematicBody
export var SPEED = 15
export var GRAVITY = 30
export var JUMP = 15
export var ROTATE = .05

var velocity = Vector3.ZERO
var y_pos = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var move_vector = Vector3()
	if Input.is_action_pressed("ui_up"):
		move_vector.z += 1
	if Input.is_action_pressed("ui_down"):
		move_vector.z -= 1
	if Input.is_action_pressed("ui_left"):
		rotate_y(ROTATE)
	if Input.is_action_pressed("ui_right"):
		rotate_y(-ROTATE)

		
	move_vector = move_vector.normalized()
	velocity.x = move_vector.x * SPEED
	velocity.y -= GRAVITY * delta
	velocity.z = move_vector.z * SPEED
	
	velocity = move_and_slide(transform.basis.xform(Vector3( 0, velocity.y, velocity.z )), Vector3.UP, true)
	
	if Input.is_action_just_pressed("ui_select"):
		velocity.y = JUMP
		


		



