extends NaveBase
class_name Jogador

var weapon = {
	"direcao" : Vector2(0,0),
	"velocidade" : 100,
	"carregado" : false,
	"recarga" : 1,
	"dano" : 0
}

var sprites = {
	"fogo" = preload("res://sprites/playerform_1.png"),
	"lua" = preload("res://sprites/playerform_2.png"),
}

const BULLET = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	aplicar_elemento("fogo")

func _physics_process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	atributos["direcao"] = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	mover_se()
	look_at(mouse_pos)
	weapon["direcao"] = global_position.direction_to(mouse_pos)
	if Input.is_action_just_pressed("mudar"):
		mudar_elemento()
	if Input.is_action_just_pressed("atirar"):
		atirar()

func mudar_elemento() -> void:
	if atributos["elemento"] == "fogo":
		aplicar_elemento("lua")
	else:
		aplicar_elemento("fogo")

func atirar() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.direcao = weapon["direcao"]
	new_bullet.speed = weapon["velocidade"]
	new_bullet.global_position = global_position
	new_bullet.rotation = weapon["direcao"].angle()
	get_tree().current_scene.add_child(new_bullet)


func aplicar_elemento(elemento: String) -> void:
	super(elemento)
	$Sprite2D.texture = sprites[elemento]
	match elemento:
		"fogo":
			weapon["velocidade"] = 200
			weapon["dano"] = 2
			weapon["recarga"] = 2
		"lua":
			weapon["velocidade"] = 100
			weapon["dano"] = 1
			weapon["recarga"] = 0.5
