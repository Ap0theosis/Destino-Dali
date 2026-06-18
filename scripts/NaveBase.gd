extends CharacterBody2D
class_name NaveBase

var atributos = {
	"direcao" : Vector2(0,0),
	"velocidade" : 100,
	"escudo" : false,
	"elemento" : "",
	"vida" : 0
}

func mover_se() -> void:
	var velocidade = atributos["velocidade"]
	var direcao = atributos["direcao"]
	velocity = velocidade * direcao.normalized()
	move_and_slide()

func take_damage(value: int) -> void:
	if atributos["escudo"]:
		atributos["escudo"] = false
		return
	
	atributos["vida"] -= value
	if atributos["vida"] <= 0:
		explodir()

func aplicar_elemento(elemento: String) -> void:
	atributos["elemento"] = elemento
	match elemento:
		"fogo":
			atributos["velocidade"] = 200
			atributos["vida"] = 5
		"lua":
			atributos["velocidade"] = 100
			atributos["vida"] = 10
			atributos["escudos"] = true

func explodir() -> void:
	queue_free()
