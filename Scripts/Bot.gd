extends KinematicBody
class_name Enemy

var movement_velocity:Vector3 = Vector3.ZERO
var direction:Vector3 = Vector3.ZERO

export var player_path:NodePath = NodePath()
onready var _agent:NavigationAgent = $NavigationAgent
onready var _player:Player = get_node(player_path)
onready var _update_timer:Timer = $UpdatePathTimer

enum{
	IDLE,
	WANDERING
	DESTROYED
}

var state:int = IDLE

func move_to_target(delta:float):
	var acceleration:float = 70.0
	var max_speed:float = 300.0
	var _friction:float = 60.0
	
	direction = global_translation.direction_to(_agent.get_next_location())
	if direction != Vector3.ZERO:
		movement_velocity += Vector3(acceleration * delta * direction.x, 0 , acceleration * delta * direction.z)
		movement_velocity = movement_velocity.limit_length(max_speed * delta)
		$scout_girl/AnimationPlayer.play("Run")
		$scout_girl.rotation.y = Vector2(-direction.x, direction.z).normalized().angle() - PI/2
		$DetectArea.rotation.y = Vector2(-direction.x, direction.z).normalized().angle() - PI/2
	elif direction == Vector3.ZERO:
		$scout_girl/AnimationPlayer.play("Idle")
	
	movement_velocity = move_and_slide(movement_velocity)


func _ready() -> void:
	 _on_UpdatePathTimer_timeout()

func _physics_process(delta:float) -> void:
	if _agent.is_navigation_finished():
		pass
		#здесь будет атака
	move_to_target(delta)



func _on_UpdatePathTimer_timeout() -> void:
	_agent.set_target_location(_player.global_translation)

