extends Area2D

var speed = 100
var direcao = Vector2(0,0)
var elemento = ""

func _process(delta: float) -> void:
	position += direcao * speed * delta
