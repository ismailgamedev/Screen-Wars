extends TextureButton


onready var _transition_rect := $SceneTransitionRect



func _on_Kare3_pressed():
	_transition_rect.transition_to("res://Scenes/Level1.tscn")
