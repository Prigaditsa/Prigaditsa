class_name BaseScene extends Node

@onready var player : Player = null
@onready var entrance_markers: Node2D = $EntranceMarkers

func _ready() -> void:
	# Проверяем, определен ли игрок в SceneManager
	if get_node("/root/scene_manager").player:
		# Используем существующего игрока
		player = get_node("/root/scene_manager").player
		add_child(player)
		position_player()
	else:
		# Создаем нового игрока, если это первая сцена
		player = load("res://Игрок/player.tscn").instantiate()
		add_child(player)
		get_node("/root/scene_manager").player = player

func position_player() -> void:
	var target_entrance = get_node("/root/scene_manager").entrance_point
	
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == target_entrance:
			player.global_position = entrance.global_position
			return
	
	# Если не нашли нужный маркер входа, используем первый доступный
	if entrance_markers.get_child_count() > 0:
		player.global_position = entrance_markers.get_child(0).global_position
