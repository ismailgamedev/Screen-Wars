extends Node2D

onready var _transition_rect := $CanvasLayer/SceneTransitionRect

func _on_NextLevel_body_entered(body):
	if body.name == "Player":
		_transition_rect.transition_to("res://Scenes/Level5.tscn")
