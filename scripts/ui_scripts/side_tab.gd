@tool
class_name SideTab extends Panel

@export var start_button : TabButton

func _ready() -> void:
	start_button.set_active_tab_button(true)
