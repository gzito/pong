extends Area2D

enum BoundaryLocation { TOP, BOTTOM, LEFT, RIGHT }
@export var location : BoundaryLocation = BoundaryLocation.TOP

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		var ball = area as Ball
		if location == BoundaryLocation.TOP or location == BoundaryLocation.BOTTOM:
			ball.direction.y = -ball.direction.y
		elif location == BoundaryLocation.LEFT:
			ball.reset()
			var n = get_node("/root/Field")
			n.rightScore += 1
			n.updateScore()
		elif location == BoundaryLocation.RIGHT:
			ball.reset()
			var n = get_node("/root/Field")
			n.leftScore += 1
			n.updateScore()
