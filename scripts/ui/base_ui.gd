extends Control
class_name BaseUI

signal opened(ui)
signal closed(ui)

var is_open: bool

func open() -> void:
	show()
	opened.emit(self)
	is_open = true

func close() -> void:
	hide()
	closed.emit(self)
	is_open = false
