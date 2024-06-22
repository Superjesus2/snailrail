extends Node2D

var animal_id
var time
var distance
var errors
var player_name

#func _input(event):
#	if event is InputEventKey :
#		get_data()

var client = HTTPClient.new()
const url_submit = 'https://docs.google.com/forms/u/0/d/e/1FAIpQLScaqMBte_LD9kXVQPi6g6JtzU_Oy-K6v5QwfYxdA_FnsT5kaw/formResponse'
const url_data = 'https://opensheet.elk.sh/1jzWyBM9m7NbcvpASi96WRwRs93hznjuAJWtORVAtu9A/1'
const headers = ['Content-Type: application/x-www-form-urlencoded']

func submit_done(http_arg) :
	http_arg.queue_free()

func fetch_done(result, _response_code, _headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("failed to fetch sheets")
		return
	
	var json_raw = body.get_string_from_utf8()
	var json = JSON.new()
	var retcode = json.parse(json_raw)
	if retcode != OK:
		print("Failed to parse sheets: JSON error at line %s: %s" \
			% [json.get_error_line(), json.get_error_message()] + \
			"\nThe input string was:\n" + json_raw)
		return
	var fetched_data = json.data
	for user in fetched_data :
		animal_id = user['animal_id']
		time = user['time']
		distance = user['distance']
		errors = user['errors']
		player_name = user['name']
	
	print("received data ", fetched_data)
	print(animal_id)
	print(time)
	
#	var data = _body.get_string_from_utf8()
#	data = data.replace("[","").replace("]","")
#	data = JSON.parse_string(data)
#	for user in data :
#		var animal_id = user['animal_id']
#		var time = user['time']
#		var distance = user['distance']
#		var errors = user['errors']
#		var player_name = user['player_name']
#	print(_body)
#	print(data)
#	print(data)

func get_data() :
	var http = HTTPRequest.new()
#	http.request_completed.connect(func():fetch_done(url_data,_headers))
	http.connect("request_completed", fetch_done)
	add_child(http)
	http.request(url_data)
	http.queue_free()
	
	
func add_data() :
	var http = HTTPRequest.new()
	http.request_completed.connect(submit_done)
	add_child(http)
	
	var user_data = client.query_string_from_dict({
		"entry.302654588": globals.high_scores[(globals.times_played)-1][0],
		"entry.395421193": globals.high_scores[(globals.times_played)-1][1],
		"entry.394589700": globals.high_scores[(globals.times_played)-1][2],
		"entry.1681711598": globals.high_scores[(globals.times_played)-1][3],
		"entry.1697431214": globals.high_scores[(globals.times_played)-1][4],
		
	})
	http.request(url_submit,headers,HTTPClient.METHOD_POST,user_data)
	http.queue_free()
