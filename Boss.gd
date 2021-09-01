extends KinematicBody2D


onready var kumanda = get_node("Kumanda")
onready var anim_player = get_node("AnimationPlayer")
onready var effekt = preload("res://Objects/DeathEffect.tscn")
onready var bullet = preload("res://Objects/bullet/EnemyBullet.tscn")
var health = 100
var death = false
var fire_check = false
export(NodePath) var player

func _ready():
	player = get_node(player)
	anim_player.play("idle")
	
	
func _physics_process(delta):
	if death == false:
		kumanda.look_at(player.global_position)
	if health <= 0:
		health = 0
		death = true
		anim_player.play("die")
	$CanvasLayer/Label2.text = str(health)

func shoot():
	if fire_check == true:
		var instance_bullet = bullet.instance()
		instance_bullet.global_position = $Kumanda.global_position
		get_parent().add_child(instance_bullet)
		$ShootSound.play()

func _on_HitBox_area_entered(area):
	if area.is_in_group("Bullet"):
		var instance_effect = effekt.instance()
		instance_effect.global_position = area.global_position
		get_parent().add_child(instance_effect)
		health -= 3
		$hitsound.play()
		area.queue_free()

		
		


func _on_Timer_timeout():
	if player.death == false and death == false:
		shoot()
