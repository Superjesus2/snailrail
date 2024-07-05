extends Node2D
#func _input(event):
#	if event is InputEventKey :
#		if event.is_pressed() and not event.is_echo():
#			get_data()

var submitting
signal completed
signal ready_to_send
signal dont_send
signal data_sent
var my_data = {}
var client = HTTPClient.new()
const url_submit = 'https://docs.google.com/forms/u/0/d/e/1FAIpQLScaqMBte_LD9kXVQPi6g6JtzU_Oy-K6v5QwfYxdA_FnsT5kaw/formResponse'
const url_data = 'https://opensheet.elk.sh/1jzWyBM9m7NbcvpASi96WRwRs93hznjuAJWtORVAtu9A/1'
const headers = ['Content-Type: application/x-www-form-urlencoded']

#func http_submit(result, _response_code, _headers, body, http) :
#	http.queue_free()

func _on_fetched(result, _response_code, _headers, body):
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
	my_data = json.data
	completed.emit()

func get_data() :
	var http = HTTPRequest.new()
	http.request_completed.connect(_on_fetched)
	add_child(http)
	var err = http.request(url_data,headers,HTTPClient.METHOD_GET)
	if err :
		http.queue_free()
	
func add_data() :
	var http = HTTPRequest.new()
#	http.request_completed.connect(http_submit)
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
	data_sent.emit()
