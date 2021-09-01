extends Area2D

var timer

func _ready():
	timer = rand_range(1.0,4.0)
	
func _process(delta):
	yield(get_tree().create_timer(timer), "timeout")
	$AnimationPlayer.play("lazer")
