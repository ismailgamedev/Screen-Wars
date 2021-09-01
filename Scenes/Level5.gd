extends Node2D


# Declare member variables here. Examples:
# var a = 2

onready var _transition_rect := $CanvasLayer/SceneTransitionRect
func _process(delta):
	if $Boss.health <= 0:
		$CanvasLayer/Finish.visible = true

func _on_Camera_body_exited(body):
	$Boss.fire_check = true
	$Camera2D2.current = true


func _on_Finish_pressed():
	_transition_rect.transition_to("res://Hikaye/Kare4.tscn")
