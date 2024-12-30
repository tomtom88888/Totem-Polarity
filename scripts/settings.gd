extends Control

@onready var music_button: HSlider = $MusicText/MusicSlider
@onready var texture_button: TextureButton = $BackButton
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_music_slider_value_changed(value: float) -> void:
	if value == 0:
		SoundPlayer.stop()
		playing = false
	elif value != 0 and playing == false:
		SoundPlayer.play()
		playing = true
	
	SoundPlayer.volume_db = -(20-value*0.2)


func _on_back_button_pressed() -> void:
		get_parent().main_menu()
