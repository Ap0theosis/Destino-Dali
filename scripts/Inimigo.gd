extends NaveBase
class_name Inimigo

var propriedades = {
	"visao" = 0,
	"alerta" = false,
	"alcance" = 0,
	"player" = null
}

func _ready() -> void:
	propriedades["player"] = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if propriedades["player"] and propriedades["alerta"]:
		look_at(propriedades["player"])
		atributos["direcao"] = global_position.direction_to(propriedades["player"])
		mover_se()
