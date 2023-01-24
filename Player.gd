extends KinematicBody
# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
var ROTATE = .05
export var JUMP = 25
var velocity = Vector3.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_left"):
		direction.x += 1
	if Input.is_action_pressed("ui_right"):
		direction.x -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if !is_on_floor():
		velocity.y -= fall_acceleration  * delta
	else:
		velocity.y = 0
		
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_just_pressed("ui_select"):
		velocity.y = JUMP
