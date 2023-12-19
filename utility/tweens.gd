static func tween_fade_out(tween: Tween, label: Label, time: float):
	return tween\
	.tween_property(label, "modulate", Color(label.modulate.r, label.modulate.g, label.modulate.b, 0), time)\
	.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

static func tween_move(tween: Tween, container, amount: int, time: float):
	return tween\
        .tween_property(container, "position", Vector2(container.position.x, container.position.y + amount), time)\
        .set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
    
