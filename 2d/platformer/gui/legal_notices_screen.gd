extends ColorRect


func _ready() -> void:
	var readme := $MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/README
	readme.text = readme.text.format({
		"game_name": ProjectSettings.get_setting("application/config/name"),
		"godot_version": Engine.get_version_info()["string"]
	})
	
	var godot_engine := $"MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Godot Engine"
	var text := ""
	text = "Godot Engine authors:\n"
	var author_info := Engine.get_author_info()
	for author_type: String in author_info:
		text += "\t" + author_type + ":\n"
		for author_name: String in author_info[author_type]:
			text += "\t\t• " + author_name + "\n"
	text += "\n\n"
	text += "Godot Engine license text:\n"
	text += Engine.get_license_text().indent("\t")
	text += "\n\n"
	text += "Copyright notices for Godot Engine components:\n"
	for piece_of_copyright_info: Dictionary in Engine.get_copyright_info():
		text += "\t• " + piece_of_copyright_info["name"] + ":\n"
		for part_number in len(piece_of_copyright_info["parts"]):
			var part: Dictionary = piece_of_copyright_info["parts"][part_number]
			text += "\t\t◦ Part %s:\n" % [part_number]
			text += "\t\t\tFile(s):\n"
			for path: String in part["files"]:
				text += "\t\t\t\t" + path + "\n"
			text += "\t\t\tCopyright notice(s) for that file or those files:\n"
			for copyright_notice: String in part["copyright"]:
				text += "\t\t\t\t© " + copyright_notice + "\n"
			text += "\t\t\tLicense ID: " + part["license"] + "\n"
	text += "\n\n"
	text += "Licnese text for Godot Engine components:\n"
	var license_info := Engine.get_license_info()
	for license_id: String in license_info:
		text += "\t" + license_id + ":\n"
		text += license_info[license_id].indent("\t\t")
	godot_engine.text = text
	
	var godot_demo_projects := $"MarginContainer/Panel/MarginContainer/VBoxContainer/TabContainer/Godot Demo Projects"
	text = ""
	for path: String in ["res://godot_demo_projects_readme.md", "res://godot_demo_projects_license.md", "res://platformer_2d_readme.md"]:
		var file := FileAccess.open(path, FileAccess.READ)
		if file == null:
			push_error("Failed to open a file that we need for the legal notices screen.")
		else:
			text += path + ":\n"
			text += file.get_as_text().indent("\t")
			text += "\n\n"
	godot_demo_projects.text = text


func _on_back_to_title_screen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/title_screen.tscn")


func _on_readme_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
