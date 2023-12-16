extends Ability

static func cast(ship: PlayerShip):
	print(ship.global_position)
	ship.global_position = Vector2(ship.global_position.x + 20, ship.global_position.y)
