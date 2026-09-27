@tool
class_name TabButton extends Button

# Enum
enum TabID {DASHBOARD, STUDY, STATS, TEMPLATES, SETTINGS}

static var active_tab_button : TabButton
static var font_size : int = 36

@export var normal_tab_style : StyleBoxFlat
@export var active_tab_style : StyleBoxFlat
@export var tab_id : TabID

func _ready():
	add_theme_font_size_override("font_size", font_size)
	
func check_active_tab_button():
	var tab_style = active_tab_style if active_tab_button == self else normal_tab_style
	add_theme_stylebox_override("normal", tab_style)
