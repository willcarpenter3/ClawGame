extends Node

var score := 0

#var player_stats : ClawStats = load("res://Resources/claw_stats.tres")

var player : Claw
var game_ui : GameUI

var auto_claws : Array[AutoClawParent]
var spawnable_auto_claw = preload("res://Scenes/auto_claw.tscn")

var spawnable_bomb = preload("res://Scenes/bomb.tscn")

func update_score(newScore: int):
	score = newScore
	game_ui.update_score_text(score)
	game_ui.update_button_statuses(score)

func update_claw_speed():
	update_score(score - 1)
	
	player.stats.speed += 1

func buy_auto_claw():
	update_score(score - 2)
	
	var auto_claw : AutoClawParent = spawnable_auto_claw.instantiate()
	auto_claws.append(auto_claw)
	
	add_child(auto_claw)
	print(player.position)
	print(player.name)
	auto_claw.initialize(Vector3(-15, 15, 15), player.global_position)
	
	
func buy_bomb():
	update_score (score - 3)
	
	var bomb = spawnable_bomb.instantiate()
	add_child(bomb)
	bomb.position = player.global_position
