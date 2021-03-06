extends Area2D

export var dir = 0
export var damage = 100
export var speed = 500
onready var root = get_tree().get_root().get_children()[0]

func _process(delta):
	var over = get_overlapping_areas()
	rotation = dir
	for i in over:
		if i.is_in_group("ammo"):
			root.ammo()
			queue_free()
			i.get_parent().health -= 0.1
			print(i.get_parent().health)
			if i.get_parent().health <= 0:
				i.get_parent().queue_free()
		if i.is_in_group("boat"):
			var ls = i.health
			i.health -= damage
			i.killedby = 0
			i.hitpos = position
			damage -= ls
			if i.health <= 0:
				root.weapons[1] += 10
				root.weapons[2] += 1 / 3
			if damage <= 0:
				queue_free()
	position = Vector2(position.x + (sin(dir) * speed * delta), position.y - speed * cos(dir) * delta)
	if position.y < -256:
		queue_free()
