class_name DBManager extends Node

var base_db : Dictionary
var custom_db : Dictionary

var BASES_PATHS : Array[String] = ["res://data/study_items/hiragana.json", "res://data/study_items/katakana.json"]

func _ready():
	for path in BASES_PATHS:
		base_db.merge(load_db(path))
	print(base_db)

func load_db(json_path : String) -> Dictionary:
	var json_file := FileAccess.open(json_path, FileAccess.READ)
	return JSON.parse_string(json_file.get_as_text())

func write_db(_json_dict : Dictionary):
	pass
