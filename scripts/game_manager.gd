extends Node

var score := 0

#var player_stats : ClawStats = load("res://Resources/claw_stats.tres")

var player : Claw
var game_ui : GameUI

func update_claw_speed():
	score -= 1 #replace with configurable cost
	player.stats.speed += 1
	game_ui.update_score_text(score)
	
