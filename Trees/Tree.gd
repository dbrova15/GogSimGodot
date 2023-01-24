extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(0, 100)
	rotate_y(my_random_number)
	
	var rdn_float = rng.randf_range(0.7, 1.2)
	print(rdn_float)
	#var rdn_float = rng.randf()
	set_scale(Vector3(rdn_float, rdn_float, rdn_float))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
