extends Area2D

@export var speed = 300
@onready var half_height = $ColorRect.size.y / 2.0
@onready var step_size = floori(half_height / 10.0)
const degrees: float = 0.7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		position += Vector2.UP * speed * delta ;
	elif Input.is_action_pressed("down"):
		position += -Vector2.UP * speed * delta ;

func get_center_y():
	return position.y + half_height

func _on_area_entered(area: Area2D) -> void:
	var factor = 0
	if area.name == "Ball":
		var ball = area as Ball
		var velocity = ball.direction * ball.speed
		if ball.get_center_y() < get_center_y():
			factor = (get_center_y() - ball.get_center_y()) / step_size
			velocity.y = -int(round(factor*degrees)) * 1.02
		elif ball.get_center_y() > get_center_y():
			factor = (ball.get_center_y() - get_center_y()) / step_size
			velocity.y = int(round(factor*degrees)) * 1.02
		else:
			velocity.y = -ball.direction * speed
		
		velocity.x = -velocity.x
		
		ball.direction = velocity.normalized()
		ball.speed = velocity.length()
