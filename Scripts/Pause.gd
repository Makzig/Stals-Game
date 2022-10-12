extends Control

onready var buttons = [$Popup/VBoxContainer/Resume, $Popup/VBoxContainer/Reload, $Popup/VBoxContainer/Exit]



func _show_animate_menu():
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	for button in buttons:
		button.rect_scale = Vector2.ZERO
		button.rect_rotation = -45.0
		$Popup/ColorRect.color = Color(0, 0, 0, 0)
		
		tween.tween_property(button, "rect_scale", Vector2.ONE, 1.0)
		tween.parallel().tween_property(button, "rect_rotation", 0.0 , 1.0)
		tween.parallel().tween_property($Popup/ColorRect, "color", Color(0, 0, 0, 0.7), 1.0 )

func hide_animate_menu():
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
	
	for button in buttons:
		button.rect_scale = Vector2.ONE
		button.rect_rotation = 0.0
		#$Popup/ColorRect.color = Color(0, 0, 0, 0)
		
		tween.tween_property(button, "rect_scale", Vector2.ZERO, 1.0)
		tween.parallel().tween_property(button, "rect_rotation", -45.0 , 1.0)

func _on_TextureButton_pressed():
	$Popup.show()
	yield(get_tree().create_timer(0.05), "timeout")
	_show_animate_menu()
	


func _on_Resume_pressed():
	hide_animate_menu()
	yield(get_tree().create_timer(3.0), "timeout")
	$Popup.hide()
