extends Control
class_name BaseUI

signal opened(ui)
signal closed(ui)

var is_open: bool

func _ready() -> void:
	connect("visibility_changed", _on_visibility_changed)

func open() -> void:
	show()
	opened.emit(self)
	is_open = true

func close() -> void:
	hide()
	closed.emit(self)
	is_open = false

func _on_visibility_changed() -> void:
	if visible:
		pass
	else:
		pass
