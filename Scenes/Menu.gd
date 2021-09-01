extends Control


onready var _transition_rect := $SceneTransitionRect

func _on_CikButton_pressed():
	get_tree().quit()


func _on_HakkindaButton_pressed():
	_transition_rect.transition_to("res://Scenes/HakkindaMenu.tscn")


func _on_OynaButton_pressed():
	_transition_rect.transition_to("res://Hikaye/Kare1.tscn")
