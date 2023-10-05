extends CenterContainer

var grid
var next
var music =0
var sound =0
var min_vol

var level =1 : set=set_level
var score =0 : set=set_score
var high_score=0 : set=set_high_score
var lines=0 : set=set_lines


signal button_pressed(button_name)

func set_level(value):
	find_child("Level").text=str(value)
	level=value


func set_score(value):
	find_child("Score").text=str(value)
	score=value


func set_high_score(value):
	find_child("HighScore").text="%08d" % value
	high_score=value


func set_lines(value):
	find_child("Lines").text = str(value)
	lines=value

func reset_stats(_high_score=0, _score=0, _lines=0, _level=1):
	self.high_score=_high_score
	self.score=_score
	self.lines=_lines
	self.level=_level


func settings(data):
	self.high_score=data.high_score
	find_child("Music").value=data.music
	find_child("Sound").value=data.sound


func _ready():
	
	grid = find_child("Grid")
	next = find_child("Next")
	min_vol = find_child("Music").get_min()
	find_child("Sound").set_min(min_vol)
	add_cells(grid, 200)
	clear_all_cells()


func set_next_shape(shape: ShapeData):
	clear_cells(next)
	var i =0
	for col in shape.coors.size():
		for row in [0,1]:
			if shape.grid[row][col]:
				next.get_child(i).modulate=shape.color
			i+=1


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
