extends Area2D

enum BoundaryLocation { TOP, BOTTOM, LEFT, RIGHT }
@export var location : BoundaryLocation = BoundaryLocation.TOP

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		var ball = area as Ball
		if location == BoundaryLocation.TOP or location == BoundaryLocation.BOTTOM:
			ball.direction.y = -ball.direction.y
		elif location == BoundaryLocation.LEFT or location == BoundaryLocation.RIGHT:
			ball.direction.x = -ball.direction.x
