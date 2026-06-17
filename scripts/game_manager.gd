extends Node

var score := 0

#var player_stats : ClawStats = load("res://Resources/claw_stats.tres")

var player : Claw
var game_ui : GameUI

var auto_claws : Array[AutoClawParent]
var spawnable_auto_claw = preload("res://Scenes/auto_claw.tscn")

func update_claw_speed():
	score -= 1 #replace with configurable cost
	player.stats.speed += 1
	game_ui.update_score_text(score)
	

func buy_auto_claw():
	score -= 2 #replace with configurable cost
	
	var auto_claw : AutoClawParent = spawnable_auto_claw.instantiate()
	auto_claws.append(auto_claw)
	
	add_child(auto_claw)
	print(player.position)
	print(player.name)
	auto_claw.initialize(Vector3(-15, 15, 15), player.global_position)
	game_ui.update_score_text(score)
	
	
