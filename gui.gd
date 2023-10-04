extends CenterContainer

var grid
var next

const CELL_BG1 = Color(.1,.1,.1)
const CELL_BG2 = Color(0)

signal button_pressed(button_name)

func _ready():
	
	grid = find_child("Grid")
	next = find_child("Next")
	add_cells(grid, 200)
	clear_cells(grid, CELL_BG1)
	clear_cells(next, CELL_BG2)
	
func add_cells(node, n):
	var num_cells=node.get_child_count()
	while num_cells<n:
		node.add_child(node.get_child(0).duplicate())
		num_cells+=1
	
func clear_cells(node, color):
	for cell in node.get_children():
		cell.modulate =color


func _on_about_button_down():
	$AboutBox.popup_centered()
	emit_signal("button_pressed", "About")


func _on_music_button_down():
	emit_signal("button_pressed", "Music")


func _on_pause_button_down():
	emit_signal("button_pressed", "Pause")


func _on_new_game_button_down():
	emit_signal("button_pressed", "NewGame")
