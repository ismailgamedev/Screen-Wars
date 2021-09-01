extends KinematicBody2D

var distance_check := false
var distance := 0
var speed := 80
var dir := Vector2.ZERO
var health := 5
var death := false

onready var kumanda = get_node("Kumanda")
onready var effekt = preload("res://Objects/DeathEffect.tscn")
onready var Animation_Player = get_node("AnimationPlayer")
onready var bullet = preload("res://Objects/bullet/EnemyBullet.tscn")

export(NodePath) var player

func _ready():
	player = get_node(player)
	Animation_Player.play("idle")

func _physics_process(delta):
	if death == false:
		kumanda.look_at(player.global_position)
	
	if health <= 0:
		health = 0
		death = true
		Animation_Player.play("die")
		
	
	if distance_check == true and death == false:
		distance = abs(position.x - player.position.x)
		if distance > 40:
			dir = (player.global_position - global_position)
			dir = dir.normalized()
			move_and_collide(dir * speed * delta)
			Animation_Player.play("walk")
		else:
			dir.x = lerp(dir.x, 0 , 0.2)
			dir.y = lerp(dir.y, 0 , 0.2)
			Animation_Player.play("idle")
			

func _on_HitBox_area_entered(area):
	if area.is_in_group("Bullet"):
		var instance_effect = effekt.instance()
		instance_effect.global_position = global_position
		get_parent().add_child(instance_effect)
		health -= 1
		$hitsound.play()
		area.queue_free()

func shoot():
	var instance_bullet = bullet.instance()
	instance_bullet.global_position = $Kumanda.global_position
	get_parent().add_child(instance_bullet)
	$ShootSound.play()

func _on_Timer_timeout():
	if distance_check == true and player.death == false and death == false:
		shoot()


func _on_DistanceCheck_area_entered(area):
	if area.get_parent().name == "Player":
		distance_check = true


func _on_DistanceCheck_area_exited(area):
	if area.get_parent().name == "Player": 
			distance_check = false
