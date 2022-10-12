extends Control
class_name Mobile_Input

signal using_move_vector(move_vector)

onready var touch:TouchScreenButton = $Control/Touch
onready var circle_sprite:Sprite = $Control/Touch/Small_Circle

export var linght_cirlce:float = 50.0

var joystick_active:bool = false
var move_vector:Vector2


func _input(event:InputEvent) -> void:
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		if touch.is_pressed():
			joystick_active = true
			move_vector = calculate_move_vector(event.position)
			


func _physics_process(_delta) -> void:
	if joystick_active:
		emit_signal("using_move_vector", move_vector)
		circle_sprite.position = move_vector * linght_cirlce + Vector2(100, 100)



func calculate_move_vector(event_position) -> Vector2:
	var texture_center:Vector2 = Vector2(104, 100) * touch.scale + touch.global_position 
	circle_sprite.visible = true
	return (event_position - texture_center).normalized()



func _on_TouchScreenButton_released() -> void:
		joystick_active = false
		move_vector = Vector2.ZERO
		emit_signal("using_move_vector" , move_vector)
		circle_sprite.visible = false
		$Control/Touch/Big_Circle.visible = false


func _on_TouchScreenButton_pressed() -> void:
	joystick_active = true
	circle_sprite.visible = true
	$Control/Touch/Big_Circle.visible = true
