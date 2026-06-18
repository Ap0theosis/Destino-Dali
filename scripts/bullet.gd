extends Area2D

var speed = 100
var direcao = Vector2(0,0)
var damage = 0
var elemento = ""

const SPRITES = {
	"fogo": preload("res://sprites/laser_1.png"),
	"lua": preload("res://sprites/laser_2.png")
}
func _ready() -> void:
	$Sprite2D.play(elemento)

func _process(delta: float) -> void:
	position += direcao * speed * delta
