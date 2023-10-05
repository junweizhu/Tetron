extends CenterContainer

var grid
var next
var music =0
var sound =0
var min_vol



signal button_pressed(button_name)

func _ready():
	
	grid = find_child("Grid")
	next = find_child("Next")
	min_vol = find_child("Music").get_min()
	find_child("Sound").set_min(min_vol)
	add_cells(grid, 200)
	clear_all_cells()
	
	
func add_cells(node, n):
	var num_cells=node.get_child_count()
	while num_cells<n:
		node.add_child(node.get_child(0).duplicate())
		num_cells+=1

func clear_all_cells():
	clear_cells(grid)
	clear_cells(next)
	
func clear_cells(node):
	for cell in node.get_children():
		cell.modulate =Color(0)


func _on_about_button_down():
	$AboutBox.popup_centered()
	emit_signal("button_pressed", "About")


func _on_pause_button_down():
	emit_signal("button_pressed", "Pause")


func _on_new_game_button_down():
	emit_signal("button_pressed", "NewGame")


func set_button_state(button, state):
	find_child(button).set_disabled(state)


func set_button_text(button,text):
	find_child(button).set_text(text)


func set_button_states(playing):
	set_button_state("NewGame", playing)
	set_button_state("About", playing)
	set_button_state("Pause", !playing)


func _on_about_box_visibility_changed():
	set_button_state("About", false)


func _on_music_value_changed(value):
	music = value
	emit_signal("button_pressed", "Music")


func _on_sound_value_changed(value):
	sound =value
	emit_signal("button_pressed", "Sound")
