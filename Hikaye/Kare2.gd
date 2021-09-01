extends TextureButton

onready var _transition_rect := $SceneTransitionRect




func _on_Kare2_pressed():
	_transition_rect.transition_to("res://Hikaye/Kare3.tscn")
