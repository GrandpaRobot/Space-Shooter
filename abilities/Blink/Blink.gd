extends Ability

static func cast(ship: PlayerShip):
	ship.global_position = Vector2(ship.global_position.x + 20, ship.global_position.y)
