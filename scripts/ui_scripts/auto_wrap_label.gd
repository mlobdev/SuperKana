extends Label

@export var minimum_size : int

func change_character(new_char : String) -> void:
	text = new_char
	set_correct_size()

func set_correct_size() -> void:
	while text_is_too_big():
		if (get_theme_font_size("font_size") < minimum_size):
			break
		add_theme_font_size_override("font_size", get_theme_font_size("font_size")-1)

func text_is_too_big() -> bool:
	var font := get_theme_font("font")
	var font_size := get_theme_font_size("font_size")
	
	var text_size := font.get_string_size(text,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size)
	
	return text_size.x > size.x or text_size.y > size.y
	
