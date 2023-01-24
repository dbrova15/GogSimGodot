extends KinematicBody

export var SPEED = 2
export var GRAVITY = 30
export var JUMP = 15
export var ROTATE = .01

var velocity = Vector3.ZERO

onready var MAN = get_node("scene")
onready var MAN_ANIM_WALK = get_node("scene/AnimationPlayer")

enum  {
	IDLE,
	WALK,
	BACK
}
var state = IDLE


func _physics_process(delta):

	walk(delta)
	rotate_y(ROTATE)

func anim_walk(action):
	if action == WALK:
		MAN_ANIM_WALK.play("Armature|Armature|mixamocom|Layer0")
	elif action == BACK:
		MAN_ANIM_WALK.play_backwards("Armature|Armature|mixamocom|Layer0")
	elif action == IDLE:
		MAN_ANIM_WALK.stop()
	
func walk(delta):
	var move_vector = Vector3()
	move_vector.z += 1
	
	move_vector = move_vector.normalized()
	velocity.y -= GRAVITY * delta
	velocity.z = move_vector.z * SPEED
	anim_walk(WALK)
	velocity = move_and_slide(transform.basis.xform(Vector3( 0, velocity.y, velocity.z )), Vector3.UP, true)
