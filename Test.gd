extends Control

var shape: ShapeData

# Called when the node enters the scene tree for the first time.

func _on_pick_shape_button_down():
	shape = Shapes.get_shape()
	$Shape.text = shape.name
	_show_grid()
	

func _on_rotate_left_button_down():
	shape.rotate_left()
	_show_grid()


func _on_rotate_right_button_down():
	shape.rotate_right()
	_show_grid()


func _show_grid():
	$Grid.text=""
	for row in shape.grid:
		for col in row:
			if col:
				$Grid.text+="x "
			else:
				$Grid.text+= "- "
		$Grid.text+="\n"

var m 

func _on_add_shape_to_grid_button_down():
	m = $Main
	m.clear_grid()
	m.shape=Shapes.get_shape()
	m.pos= int($SpinBox.value)
	m.add_shape_to_grid()


func _on_remove_shape_from_grid_button_down():
	m.remove_shape_from_grid()


func _on_lock_button_down():
	m.lock_shape_to_grid()

func _input(event):
	if m:
		var new_pos=m.pos
		var dir=null
		if event.is_action_pressed("ui_down"):
			new_pos+= m.cols
		if event.is_action_pressed("ui_left"):
			new_pos-=1
		if event.is_action_pressed("ui_right"):
			new_pos+=1
		if event.is_action_pressed("ui_up"):
			new_pos-=m.cols
		if event.is_action_pressed("ui_page_down"):
			dir=m.ROTATE_LEFT
		if event.is_action_pressed("ui_page_up"):
			dir=m.ROTATE_RIGHT
		if new_pos !=m.pos or dir!=null:
			m.move_shape(new_pos, dir)
			get_viewport().set_input_as_handled()
