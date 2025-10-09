extends CharacterBody3D

const SPEED = 5.0
var hero
@export var turn_speed = 4.0

func _ready():
	hero = get_tree().get_nodes_in_group("player")[0]
	
func _physics_process(delta: float) -> void:
	$FaceDirection.look_at(hero.global_transform.origin, Vector3.UP)
	rotate_y(deg_to_rad($FaceDirection.rotation.y * turn_speed))
	$NavigationAgent3D.set_target_position(hero.global_transform.origin)
	var velocity = ($NavigationAgent3D.get_next_path_position() - transform.origin).normalized() * SPEED * delta
	move_and_collide(velocity)
