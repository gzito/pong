extends Area2D

@export var humanControlled: bool = true
@export var speed: float = 300.0
@onready var _half_height : float = $ColorRect.size.y / 2.0

func _process(delta: float) -> void:
	if humanControlled:
		var displacement = DisplayServer.mouse_get_position().y
		var winpos = get_window().position.y
		var relativeY = displacement- winpos
		if relativeY > 0:
			if relativeY + $ColorRect.size.y < get_window().size.y:
				position.y = displacement - winpos
	else:
		var ball = get_node("/root/Field/Ball") as Ball
		var dest = ball.position.y - (_half_height - ball._half_height)
		position.y += (dest - position.y)
		position.y = max(min(position.y,get_window().size.y-$ColorRect.size.y),0)
		print(position.y)

func get_center_y() -> float:
	return position.y + _half_height

func _on_area_entered(area: Area2D) -> void:
	var factor = 0
	if area.name == "Ball":
		var ball = area as Ball
		var velocity = ball.direction * ball.speed
		velocity.y = remap(ball.get_center_y()-get_center_y(),-_half_height,_half_height,-250,250)
		velocity.x = -velocity.x
		ball.direction = velocity.normalized()
		ball.speed = velocity.length()
		ball.accelerate()
