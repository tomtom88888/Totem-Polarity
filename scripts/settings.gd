extends Control

@onready var music_button: CheckButton = $MusicText/MusicButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_music_slider_value_changed(value: float) -> void:
	SoundPlayer.volume_db = -(20-value*0.2)
