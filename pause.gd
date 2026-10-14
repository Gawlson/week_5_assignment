extends CanvasLayer

@onready var resume_btn = $CenterContainer/VBoxContainer/resume
@onready var options_btn = $CenterContainer/VBoxContainer/options
@onready var sound_btn = $CenterContainer/VBoxContainer/icons/sound
@onready var save_btn = $CenterContainer/VBoxContainer/icons/save
@onready var menu_btn = $CenterContainer/VBoxContainer/mainmenu

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

	resume_btn.pressed.connect(toggle)
	options_btn.pressed.connect(_on_options)
	sound_btn.pressed.connect(_on_sound)
	save_btn.pressed.connect(_on_save)
	menu_btn.pressed.connect(_on_main_menu)

	resume_btn.text = "Resume"
	options_btn.text = "Options"
	menu_btn.text = "Main Menu"
	for b in [resume_btn, options_btn, menu_btn]:
		b.custom_minimum_size = Vector2(120, 28)
		b.add_theme_font_size_override("font_size", 16)

	sound_btn.icon = load("res://sound.png")
	save_btn.icon = load("res://save.png")
	for b in [sound_btn, save_btn]:
		b.text = ""
		b.flat = true
		b.expand_icon = true
		b.custom_minimum_size = Vector2(32, 32)

	var vbox = $CenterContainer/VBoxContainer
	vbox.add_theme_constant_override("separation", 6)

	var title = Label.new()
	title.text = "PAUSED"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(title)
	vbox.move_child(title, 0)

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE or event.keycode == KEY_P:
			toggle()

func toggle():
	visible = not visible
	get_tree().paused = visible

func _on_options():
	var options = load("res://scenes/options.tscn").instantiate()
	options.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(options)

func _on_sound():
	var muted = AudioServer.is_bus_mute(0)
	AudioServer.set_bus_mute(0, not muted)

func _on_save():
	pass

func _on_main_menu():
	get_tree().paused = false
	hide()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
