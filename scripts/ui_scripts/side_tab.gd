@tool
class_name SideTab extends Panel

@export var button_container : Control
@export var start_button : TabButton

signal menu_changed(ID : TabButton.TabID)

func _ready() -> void:
	if(start_button):
		TabButton.active_tab_button = start_button
	else:
		TabButton.active_tab_button = button_container.get_child(0)
	for button : TabButton in button_container.get_children():
		button.pressed.connect(select_new_button.bind(button))

func select_new_button(new_button : TabButton):
	TabButton.active_tab_button = new_button
	menu_changed.emit(new_button.tab_id)
	update_buttons()

func update_buttons() -> void:
	if (TabButton.active_tab_button == null): return
	for button in button_container.get_children():
		button.check_active_tab_button()
