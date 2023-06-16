extends Control

@onready var gui: CanvasLayer = $gui

enum UI {
	Fader,
	PauseMenu,
}

@onready var uis: Dictionary = {
	UI.Fader: preload("res://scenes/ui/fader.tscn"),
	UI.PauseMenu: preload("res://scenes/ui/pause_menu.tscn"),
}

var active_uis: Array
var inactive_uis: Array
var instanced_uis: Dictionary
var current_ui: BaseUI

func open_ui(ui_type: UI, re_instance: bool = false) -> BaseUI:
	var ui: BaseUI = null
	if re_instance:
		free_ui(ui_type)
		ui = instance_ui(ui_type)
	else:
		ui = get_ui(ui_type)
	current_ui = ui
	ui.open()
	if not active_uis.has(ui):
		active_uis.append(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	return ui

func close_ui(ui_type: UI, free: bool = false) -> BaseUI:
	if not uis.has(ui_type):
		return null
	var ui: BaseUI = instanced_uis[ui_type]
	ui.close()
	if not inactive_uis.has(ui):
		inactive_uis.append(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if free:
		free_ui(ui_type)
		return null
	current_ui = active_uis[-1] if len(active_uis) > 0 else null
	return ui

func get_ui(ui_type: UI) -> BaseUI:
	if not uis.has(ui_type):
		return null
	if not instanced_uis.has(ui_type) or instanced_uis[ui_type] == null:
		instance_ui(ui_type)
	if not is_instance_valid(instanced_uis[ui_type]):
		return null
	var ui: BaseUI = instanced_uis[ui_type]
	return ui

func instance_ui(ui_type: UI, start_open = false) -> BaseUI:
	if not uis.has(ui_type):
		return null
	var instanced_ui: BaseUI = uis[ui_type].instantiate()
	instanced_ui.name = str(ui_type)
	instanced_uis[ui_type] = instanced_ui
	gui.add_child(instanced_ui)
	if not start_open:
		instanced_ui.hide()
	return instanced_ui

func free_ui(ui_type: UI) -> void:
	if not uis.has(ui_type):
		return
	var ui: BaseUI = instanced_uis[ui_type]
	if ui == null: return
	instanced_uis.erase(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	ui.queue_free()

func initialize_in_game_uis() -> void:
	get_ui(UI.PauseMenu)
