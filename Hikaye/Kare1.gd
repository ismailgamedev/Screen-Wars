extends TextureButton

onready var _transition_rect := $SceneTransitionRect


func _on_Kare1_pressed():
	_transition_rect.transition_to("res://Hikaye/Kare2.tscn")
