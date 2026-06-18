extends NaveBase
class_name Inimigo

var propriedades = {
	"visao" = 0,
	"alerta" = false,
	"alcance" = 0,
	"dano" = 0,
	"player" = null
}

func _ready() -> void:
	propriedades["player"] = get_tree().get_first_node_in_group("player")
	atributos["vida"] = 100

func _physics_process(delta: float) -> void:
	if propriedades["player"] and propriedades["alerta"]:
		look_at(propriedades["player"].global_position)
		atributos["direcao"] = global_position.direction_to(propriedades["player"].global_position)
		mover_se()

func take_damage(value: int) -> void:
	super(value)
	propriedades["alerta"] = true

func _on_hurt_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		take_damage(area.damage)
		area.queue_free()
