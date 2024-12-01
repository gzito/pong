class_name Ball
extends Area2D

@export var speed = 350.0
@export var direction = Vector2(-1,-1).normalized()
@export var accel = 20.0
@onready var half_height_ = $ColorRect.size.y / 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
#	speed += accel * delta

func get_center_y():
	return position.y + half_height_
