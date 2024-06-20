extends Node2D

#entry.302654588: 'snail'
#entry.395421193: 24.15
#entry.394589700: 17.5
#entry.1681711598: 9
#entry.1697431214: AVF

func _input(event):
	if event is InputEventKey :
		get_data()

var client = HTTPClient.new()
const url_submit = 'https://docs.google.com/forms/u/0/d/e/1FAIpQLScaqMBte_LD9kXVQPi6g6JtzU_Oy-K6v5QwfYxdA_FnsT5kaw/formResponse'
const headers = ['Content-Type: application/x-www-form-urlencoded']
const url_data = 'https://opensheet.elk.sh/1jzWyBM9m7NbcvpASi96WRwRs93hznjuAJWtORVAtu9A/1'

func http_submit(_result, _response_code, _headers, _body, http) :
	http.queue_free()

func http_done(_result, _response_code, _headers, _body, http) :
	http.queue_free()
	if !_result :
		var data = JSON.parse_string(_body.get_string_from_utf8())
		for user in data :
			var animal_id = user['animal_id']
			var time = user['time']
			var distance = user['distance']
			var errors = user['errors']
			var player_name = user['name']
		print(data)

func get_data() :
	var http = HTTPRequest.new()
	http.request_completed.connect(http_done)
	add_child(http)
	
	var err = http.request(url_data,headers,HTTPClient.METHOD_GET)
	if err :
		http.queue_free()
	
	

func add_data() :
	var http = HTTPRequest.new()
	http.request_completed.connect(http_submit)
	add_child(http)
	
	var user_data = client.query_string_from_dict({
		"entry.302654588": globals.high_scores[(globals.times_played)-1][0],
		"entry.395421193": globals.high_scores[(globals.times_played)-1][1],
		"entry.394589700": globals.high_scores[(globals.times_played)-1][2],
		"entry.1681711598": globals.high_scores[(globals.times_played)-1][3],
		"entry.1697431214": globals.high_scores[(globals.times_played)-1][4],
		
	})
	var err = http.request(url_submit,headers,HTTPClient.METHOD_POST,user_data)
	if err :
		http.queue_free()
