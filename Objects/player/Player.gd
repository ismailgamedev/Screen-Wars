extends KinematicBody2D

var speed := 130
var friction := 0.4
var acceleration := 0.3
var velocity := Vector2()
var bullets := 20
var can_get_bullet := false
var power
export var health := 20
var death := false

onready var Animation_Player = get_node("AnimationPlayer")
onready var kumanda = get_node("Kumanda")
onready var mermi = preload("res://Objects/bullet/Bullet.tscn")
onready var _transition_rect := $SceneTransitionRect

func _ready():
	$CanvasLayer/PowerValue.text = str(bullets)
	$CanvasLayer/SinyalValue.text = str(health)


func get_input():
	var input = Vector2()
	if Input.is_action_pressed("ui_right") and death == false:
		input.x += 1
	if Input.is_action_pressed("ui_left") and death == false:
		input.x -= 1
	if Input.is_action_pressed("ui_down") and death == false:
		input.y += 1
	if Input.is_action_pressed("ui_up") and death == false:
		input.y -= 1
	return input
	
func kumanda_look_at() -> void:
	if death == false:
		kumanda.look_at(get_global_mouse_position())

func _physics_process(delta):
	var direction = get_input()
	if health < 1:
		health = 0
		$CanvasLayer/PowerValue.text = str(health)
		death = true
		Animation_Player.play("die")
		$CanvasLayer/TryAgainButton.visible = true

	if direction.length() > 0 and death == false:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
		Animation_Player.play("walk")
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		if death == false:
			Animation_Player.play("idle")
			
	velocity = move_and_slide(velocity)
	
	kumanda_look_at()
	shoot()
	get_bullet()
	
func shoot():
	if Input.is_action_just_pressed("fire") and bullets > 0 and death == false:
		var instance_bullet = mermi.instance()
		instance_bullet.global_position = $Kumanda/aim.global_position
		get_parent().add_child(instance_bullet)
		bullets -= 1
		$ShootSound.play()
		$CanvasLayer/PowerValue.text = str(bullets)

func _on_BulletGet_area_entered(area):
	if area.is_in_group("BulletPower"):
		can_get_bullet = true
		power = area.get_parent()

func _on_BulletGet_area_exited(area):
	if area.is_in_group("BulletPower"):
		can_get_bullet = false

func get_bullet():
	if Input.is_action_just_pressed("get") and can_get_bullet == true and death == false:
		bullets += 1
		power.queue_free()
		$CanvasLayer/PowerValue.text = str(bullets)


func _on_HitBox_area_entered(area):
	if area.is_in_group("EnemyBullet"):
		health -= 1
		$CanvasLayer/SinyalValue.text = str(health)
		$hitsound.play()
	if area.is_in_group("Tuzak"):
		health -= 40
		$hitsound.play()
		$CanvasLayer/SinyalValue.text = str(health)
		


func _on_Button_pressed():
	get_tree().reload_current_scene()




func _on_Camera_body_entered(body):
	$Camera2D.current = false
