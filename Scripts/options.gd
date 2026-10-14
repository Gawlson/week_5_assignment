extends Node2D

func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")

func _on_return_pressed() -> void:
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	
func _on_fade_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_english_pressed() -> void:
	TranslationServer.set_locale("english")

func _on_spanish_pressed() -> void:
	TranslationServer.set_locale("spanish")
