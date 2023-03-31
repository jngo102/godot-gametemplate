extends Control

@onready var gui: CanvasLayer = $gui

@onready var uis: Dictionary = {
	"fader": preload("res://gui/fader/fader.tscn"),
	"pause_menu": preload("res://gui/pause_menu/pause_menu.tscn"),
}

var active_uis: Array
var inactive_uis: Array
var instanced_uis: Dictionary
var current_ui: BaseUI

func open_ui(ui_name: String, re_instance: bool = false) -> BaseUI:
	var ui: BaseUI = null
	if re_instance:
		free_ui(ui_name)
		ui = instance_ui(ui_name)
	else:
		ui = get_ui(ui_name)
	current_ui = ui
	ui.open()
	if not active_uis.has(ui):
		active_uis.append(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	return ui

func close_ui(ui_name: String, free: bool = false) -> BaseUI:
	if not uis.has(ui_name):
		return null
	var ui: BaseUI = instanced_uis[ui_name]
	ui.close()
	if not inactive_uis.has(ui):
		inactive_uis.append(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if free:
		free_ui(ui_name)
		return null
	current_ui = active_uis[-1] if len(active_uis) > 0 else null
	return ui

func get_ui(ui_name: String) -> BaseUI:
	if not uis.has(ui_name):
		return null
	if not instanced_uis.has(ui_name):
		instance_ui(ui_name)
	var ui: BaseUI = instanced_uis[ui_name]
	return ui

func instance_ui(ui_name: String, start_open = false) -> BaseUI:
	if not uis.has(ui_name):
		return null
	var instanced_ui: BaseUI = uis[ui_name].instantiate()
	instanced_ui.name = ui_name
	instanced_uis[ui_name] = instanced_ui
	gui.add_child(instanced_ui)
	if not start_open:
		instanced_ui.hide()
	return instanced_ui

func free_ui(ui_name: String) -> void:
	if not uis.has(ui_name):
		return
	var ui: BaseUI = instanced_uis[ui_name]
	instanced_uis.erase(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	ui.queue_free()
