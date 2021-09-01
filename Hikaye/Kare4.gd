extends TextureButton


onready var _transition_rect := $SceneTransitionRect

func _on_Kare4_pressed():
	_transition_rect.transition_to("res://Scenes/Son.tscn")
