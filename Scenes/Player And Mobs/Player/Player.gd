extends KinematicBody
class_name Player

var movement_velocity:Vector3 = Vector3.ZERO
var input_velocity:Vector2

enum{
	DEAD,
	MOVE,
	FINISH
}
var state:int = MOVE


func movement(delta:float) -> void:
	var max_speed:float = 600.0
	var aceleration:float = 50.0
	var friction:float = 60.0
	var look_direction: Vector2
	
	if input_velocity != Vector2.ZERO:
		movement_velocity += Vector3(input_velocity.x * delta * aceleration, 0, input_velocity.y * delta * aceleration)
		movement_velocity = movement_velocity.limit_length(max_speed * delta)
		look_direction = Vector2(input_velocity.x, -input_velocity.y)
		$fox/AnimationPlayer.play("Run")
		$fox.rotation.y = look_direction.normalized().angle() + PI/2
		
	elif input_velocity == Vector2.ZERO:
		movement_velocity = movement_velocity.move_toward(Vector3.ZERO, friction * delta)
		$fox/AnimationPlayer.play("Idle")
		
	movement_velocity = move_and_slide(movement_velocity)


func _physics_process(delta:float) -> void:
	movement(delta)


func _on_JoyStick_using_move_vector(move_vector) -> void:
	input_velocity = move_vector
	

