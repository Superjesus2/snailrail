extends Node

var just_started = true
var player_selected = 0
var time = 60
var distance = 0
var errors = 0
var player_name = ''
#var best_players = ["snail", "slug", "elephant"]
#var best_times = [32.14,50.20,3]
#var best_distances = [500,18,22]
#var best_errors = [0,2,3]
var times_played = 0

var high_scores = [
#["snail", 58.42, 0, 0],
#["snail", 31.45, 50, 6],
#["centipede", 60, 38, 17],
#["slug", 23.24, 50, 24],
#["butterfly", 26.07, 50, 26],
#["elephant", 26.07, 50, 26],
					]

var first_try = true

var players = ["snail","slug","butterfly","spider","elephant","centipede"]

const animals = {
	"snail": {
			"keycodes": [KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S","D","F","G","H","J","K","L"],
			"sprite": ["res://resources and assets/sprites/snail_sprite_0.png",
			 "res://resources and assets/sprites/snail_sprite_1.png",
			"res://resources and assets/sprites/snail_sprite_2.png",
			"res://resources and assets/sprites/snail_sprite_3.png",] ,
			"vitesse_max": 150. ,
			"can go left": true ,
			"is animated": false ,
					},
	"slug": {
			"keycodes": [KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K],
			"keylabels": ["D","F","G","H","J","K"],
			"sprite": ["res://resources and assets/sprites/slug_sprite_0.png",
			 "res://resources and assets/sprites/slug_sprite_1.png",
			"res://resources and assets/sprites/slug_sprite_2.png",
			"res://resources and assets/sprites/slug_sprite_3.png",] ,
			"vitesse_max": 110. ,
			"can go left": true ,
			"is animated": false ,
					},
	"butterfly": {
			"keycodes": [KEY_S, KEY_L, KEY_E,KEY_I, KEY_R, KEY_U],
			"keylabels": ["S","L","E","I","R","U"],
			"sprite": ["res://resources and assets/sprites/butterfly_sprite_0.png",
			 "res://resources and assets/sprites/butterfly_sprite_1.png",
			"res://resources and assets/sprites/butterfly_sprite_2.png",
			"res://resources and assets/sprites/butterfly_sprite_3.png",] ,
			"vitesse_max": 100. ,
			"can go left": false ,
			"is animated": true ,
					},
	"spider": {
			"keycodes": [KEY_S, KEY_L, KEY_E,KEY_I, KEY_F, KEY_J, KEY_T, KEY_Y,],
			"keylabels": ["S","L","E","I","F","J","T","Y"],
			"sprite": ["res://resources and assets/sprites/spider_sprite_0.png",
			 "res://resources and assets/sprites/spider_sprite_1.png",
			"res://resources and assets/sprites/spider_sprite_2.png",
			"res://resources and assets/sprites/spider_sprite_3.png",] ,
			"vitesse_max": 200. ,
			"can go left": false ,
			"is animated": true ,
					},
	"centipede": {
			"keycodes": [KEY_S, KEY_E, KEY_R, KEY_D, KEY_V, KEY_F, KEY_T, KEY_Y, \
					KEY_G, KEY_B, KEY_N, KEY_H, KEY_U, KEY_I, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S", "E", "R", "D", "V", "F", "T", "Y", "G", \
							"B", "N", "H", "U", "I", "J", "K", "L"],
			"sprite": ["res://resources and assets/sprites/centipede_sprite_0.png",
			 "res://resources and assets/sprites/centipede_sprite_1.png",
			"res://resources and assets/sprites/centipede_sprite_2.png",
			"res://resources and assets/sprites/centipede_sprite_3.png",] ,
			"vitesse_max": 300. ,
			"can go left": true ,
			"is animated": true ,
					},
	"elephant": {
			"keycodes": [KEY_S,KEY_F,KEY_H,KEY_K,KEY_D,KEY_G,KEY_J,KEY_L],
			"keylabels": ["S","F","H","K","D","G","J","L"],
			"sprite": ["res://resources and assets/sprites/elephant_sprite_0.png",
			 "res://resources and assets/sprites/elephant_sprite_1.png",
			"res://resources and assets/sprites/elephant_sprite_2.png",
			"res://resources and assets/sprites/elephant_sprite_3.png",] ,
			"vitesse_max": 150. ,
			"can go left": false ,
			"is animated": true ,
					},
	# TODO
}
