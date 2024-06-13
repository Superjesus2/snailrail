extends Node

var player_selected = 0
var score = 60
var distance = 0
var errors = 0
var best_scores = []
var best_distances = []
var best_errors = []
var first_try = true

var players = ["snail","slug","elephant","butterfly","spider","centipede"]

const animals = {
	"snail": {
			"keycodes": [KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S","D","F","G","H","J","K","L"],
			"sprite": "res://resources and assets/snail_sprite.png" ,
			"vitesse_max": 150. ,
			"can go left": true ,
					},
	"slug": {
			"keycodes": [KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K],
			"keylabels": ["D","F","G","H","J","K"],
			"sprite": "res://resources and assets/slug_sprite.png" ,
			"vitesse_max": 110. ,
			"can go left": true ,
					},
	"butterfly": {
			"keycodes": [KEY_S, KEY_L, KEY_E,KEY_I, KEY_R, KEY_U],
			"keylabels": ["S","L","E","I","R","U"],
			"sprite": "res://resources and assets/butterfly_sprite.png" ,
			"vitesse_max": 100. ,
			"can go left": false ,
					},
	"spider": {
			"keycodes": [KEY_S, KEY_L, KEY_E,KEY_I, KEY_F, KEY_J, KEY_T, KEY_Y,],
			"keylabels": ["S","L","E","I","F","J","T","Y"],
			"sprite": "res://resources and assets/spider_sprite.png" ,
			"vitesse_max": 200. ,
			"can go left": false ,
					},
	"centipede": {
			"keycodes": [KEY_S, KEY_E, KEY_R, KEY_D, KEY_V, KEY_F, KEY_T, KEY_Y, \
					KEY_G, KEY_B, KEY_N, KEY_H, KEY_U, KEY_I, KEY_J, KEY_K, KEY_L],
			"keylabels": ["S", "E", "R", "D", "V", "F", "T", "Y", "G", \
							"B", "N", "H", "U", "I", "J", "K", "L"],
			"sprite": "res://resources and assets/centipede_sprite.png" ,
			"vitesse_max": 300. ,
			"can go left": true ,
					},
	"elephant": {
			"keycodes": [KEY_S,KEY_F,KEY_H,KEY_K,KEY_D,KEY_G,KEY_J,KEY_L],
			"keylabels": ["S","F","H","K","D","G","J","L"],
			"sprite": "res://resources and assets/elephant_sprite.png" ,
			"vitesse_max": 150. ,
			"can go left": false ,
					},
	# TODO
}
