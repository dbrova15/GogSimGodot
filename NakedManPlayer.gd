extends KinematicBody

var velocity = Vector3.ZERO
export var SPEED = 5
export var GRAVITY = -30
export var JUMP = 15
var mouse_pos = Vector2.ZERO

enum  {
	IDLE,
	WALK,
	BACK
}
var state = IDLE
onready var MAN = get_node("scene")
onready var MAN_ANIM_WALK = get_node("scene/AnimationPlayer")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()
	
	var move_vector = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		move_vector.z += 1
		anim_walk(WALK)
	if Input.is_action_pressed("ui_down"):
		move_vector.z -= 1
		anim_walk(BACK)
				
	if Input.is_action_pressed("ui_left"):
		move_vector.x += 1
		anim_walk(WALK)
	if Input.is_action_pressed("ui_right"):
		move_vector.x -= 1
		anim_walk(WALK)
		
	if Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		anim_walk(IDLE)

	
	move_vector = move_vector.rotated(Vector3(0,1,0), rotation.y).normalized()
	
	velocity.y += GRAVITY * delta
	velocity.x = move_vector.x * SPEED
	velocity.z = move_vector.z * SPEED
	
	velocity = move_and_slide(velocity,Vector3(0,1,0), true)
#	velocity = move_and_slide(transform.basis.xform(velocity), Vector3(0,1,0), true)

	if Input.is_action_just_pressed("ui_select"):
		velocity.y = JUMP

func _input(event):
	if event is InputEventMouseMotion:
		var relative = event.get_relative()
		mouse_pos.x += relative.y * 0.005
		mouse_pos.y -= relative.x * 0.005
		
		if mouse_pos.x > 1.0: mouse_pos.x = 0.99
		if mouse_pos.x < -1.0: mouse_pos.x = -0.99

		transform.basis = Basis(Vector3(0,1,0), mouse_pos.y)
		$cam.transform.basis = Basis(Vector3(1,0,0), mouse_pos.x)
#		rotation.x = $cam.rotation.x
		
func anim_walk(action):
	if action == WALK:
		MAN_ANIM_WALK.play("Armature|Armature|mixamocom|Layer0")
	elif action == BACK:
		MAN_ANIM_WALK.play_backwards("Armature|Armature|mixamocom|Layer0")
	elif action == IDLE:
		MAN_ANIM_WALK.stop()
