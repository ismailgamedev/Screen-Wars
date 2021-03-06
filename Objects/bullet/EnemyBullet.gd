extends Area2D

onready var MAXSPEED = 8
onready var player_Position = Vector2.ZERO
onready var direction = Vector2.ZERO
onready var origin = self.global_position

func _ready():
	if get_tree().get_current_scene().get_name() == "Level1":
		player_Position = get_node("/root/Level1/Player").get_global_position()
		
	if get_tree().get_current_scene().get_name() == "Level2":
		player_Position = get_node("/root/Level2/Player").get_global_position()
		
	if get_tree().get_current_scene().get_name() == "Level3":
		player_Position = get_node("/root/Level3/Player").get_global_position()
		
	if get_tree().get_current_scene().get_name() == "Level4":
		player_Position = get_node("/root/Level4/Player").get_global_position()
	if get_tree().get_current_scene().get_name() == "Level5":
		player_Position = get_node("/root/Level5/Player").get_global_position()
		
	direction = (player_Position - origin).normalized()
	look_at(player_Position)
func _physics_process(delta):
	# Mermiyi fare pozisyonuna gonderme
	direction = direction.move_toward(player_Position,delta)
	direction = direction.normalized() * MAXSPEED
	position = position + direction

# Ekrandan cikinca silinmesi icin
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_EnemyBullet_body_entered(body):
	if not body.is_in_group("Enemy"):
		self.queue_free()
