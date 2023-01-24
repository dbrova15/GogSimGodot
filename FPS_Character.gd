extends KinematicBody

var velocity = Vector3.ZERO
var y_pos = 0
export var SPEED = 15
export var GRAVITY = -30
export var JUMP = 15
var mouse_pos = Vector2.ZERO
var rot_UP = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()
	
	var move_vector = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		move_vector.z -= 1
	if Input.is_action_pressed("ui_down"):
		move_vector.z += 1
	if Input.is_action_pressed("ui_left"):
		move_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_vector.x += 1
	
	move_vector = move_vector.rotated(Vector3(0,1,0), rotation.y).normalized()
	
	velocity.y += GRAVITY * delta
	velocity.x = move_vector.x * SPEED
	velocity.z = move_vector.z * SPEED
	
	velocity = move_and_slide(velocity,Vector3(0,1,0))
#	velocity = move_and_slide(transform.basis.xform(velocity), Vector3(0,1,0), true)

	if Input.is_action_just_pressed("ui_select"):
		velocity.y = JUMP

func _input(event):
	if event is InputEventMouseMotion:
		var relative = event.get_relative()
		mouse_pos.x -= relative.y * 0.01
		mouse_pos.y -= relative.x * 0.01
		
		if mouse_pos.x > 1.0: mouse_pos.x = 0.99
		if mouse_pos.x < -1.0: mouse_pos.x = -0.99

		transform.basis = Basis(Vector3(0,1,0), mouse_pos.y)
		$cam.transform.basis = Basis(Vector3(1,0,0), mouse_pos.x)
#		rotation.x = $cam.rotation.x
		
