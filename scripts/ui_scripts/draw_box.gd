class_name DrawBox extends TextureRect

@export var canvas_color : Color
@export var canvas_size : Vector2i = Vector2(512, 512)
@export var paint_color : Color = Color("2dd4bf")
@export var paint_size : int = 8
@export var erase_size: int = 12
var image : Image

func _exit_tree():
	if Engine.is_editor_hint():
		texture = null
		
func _ready():
	image = Image.create_empty(canvas_size.x, canvas_size.y, false, Image.FORMAT_RGB8)
	image.fill(canvas_color)
	texture = ImageTexture.create_from_image(image)

var last_mouse_pos: Vector2i

func _process(_delta: float) -> void:
	var mouse_pos := Vector2i((get_global_mouse_position() - global_position).round())

	if Input.is_action_just_pressed("click"):
		draw_point(mouse_pos, paint_size, paint_color)
		last_mouse_pos = mouse_pos
		texture.update(image)

	elif Input.is_action_pressed("click"):
		if mouse_pos != last_mouse_pos:
			draw_line_between(last_mouse_pos, mouse_pos, paint_color, paint_size, canvas_size)
			last_mouse_pos = mouse_pos
			texture.update(image)
			
	elif Input.is_action_just_pressed("right_click"):
		draw_point(mouse_pos, erase_size, canvas_color)
		last_mouse_pos = mouse_pos
		texture.update(image)

	elif Input.is_action_pressed("right_click"):
		if mouse_pos != last_mouse_pos:
			draw_line_between(last_mouse_pos, mouse_pos, canvas_color, erase_size, canvas_size)
			last_mouse_pos = mouse_pos
			texture.update(image)

func draw_line_between(from: Vector2i, to: Vector2i, line_color : Color, line_size : int, img_limits : Vector2i) -> void:
	var dx = abs(to.x - from.x)
	var dy = abs(to.y - from.y)

	var sx := 1 if from.x < to.x else -1
	var sy := 1 if from.y < to.y else -1

	var err = dx - dy
	var current := from

	while true:
		draw_point(current, line_size, line_color, img_limits)
		
		if current == to:
			break
		
		var e2 = err * 2

		if e2 > -dy:
			err -= dy
			current.x += sx

		if e2 < dx:
			err += dx
			current.y += sy

func draw_point(paint_vector : Vector2i, stroke_size : int, stroke_color : Color, limits : Vector2i = Vector2i(512, 512)) -> void:
	var radius : int = int(stroke_size*0.5);
	for y in range(-radius, radius + 1):
		for x in range(-radius, radius + 1):
			# Mantener forma circular
			if x * x + y * y > radius * radius:
				continue
			var paint_pixel : Vector2i = paint_vector + Vector2i(x, y)
			if(paint_pixel.x >= 0 and paint_pixel.y >= 0 and paint_pixel.x < limits.x and paint_pixel.y < limits.y):
				image.set_pixelv(paint_pixel, stroke_color)
