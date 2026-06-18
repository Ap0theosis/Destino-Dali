extends NaveBase
class_name Inimigo

var propriedades = {
	"visao" = 0,
	"alerta" = false,
	"alcance" = 0,
	"dano" = 0,
	"player" = null
}

const EXPLOSION = preload("res://scenes/explosion.tscn")

const SPRITES = {
	"fogo" = preload("res://sprites/inimigoform_1.png"),
	"lua" = preload("res://sprites/inimigoform_2.png")
}
func _ready() -> void:
	propriedades["player"] = get_tree().get_first_node_in_group("player")
	atributos["vida"] = 100
	atributos["alcance"] = 2
	atributos["elemento"] = "fogo"
	atributos["velocidade"] = 100

func _physics_process(delta: float) -> void:
	$ProgressBar.value = atributos["vida"]
	if propriedades["player"] and propriedades["alerta"]:
		look_at(propriedades["player"].global_position)
		atributos["direcao"] = global_position.direction_to(propriedades["player"].global_position)
		mover_se()

func take_damage(value: int) -> void:
	if atributos["vida"] <= 0:
		var new_explosion = EXPLOSION.instantiate()
		new_explosion.global_position = global_position
		new_explosion.scale = propriedades["alcance"]
		get_tree().current_scene.add_child(new_explosion)
	if atributos["vida"] <= 50:
		$Sprite2D.texture = SPRITES["lua"]
		atributos["elemento"] = "lua"
		atributos["velocidade"] = 150
	super(value)
	propriedades["alerta"] = true

func _on_hurt_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area.elemento == atributos["elemento"]:
			return
		take_damage(area.damage)
		area.queue_free()
