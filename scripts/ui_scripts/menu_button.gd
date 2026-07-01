@tool
class_name TabButton extends Button

static var active_tab_button : TabButton
static var font_size : int = 36

@export var normal_tab_style : StyleBoxFlat
@export var active_tab_style : StyleBoxFlat

func _ready():
	add_theme_font_size_override("font_size", font_size)
	set_active_tab_button(false)
	
func set_active_tab_button(active : bool):
	var style : StyleBoxFlat = active_tab_style if active == true else normal_tab_style
	add_theme_stylebox_override("normal", style) 
