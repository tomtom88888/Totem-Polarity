extends Node2D

const COURSE_2 = preload("res://levels/tutorial/course_2.tscn")
const COURSE_3 = preload("res://levels/tutorial/course_3.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_course_1_go_into_exit() -> void:
	$course1.queue_free()
	var course_2 = COURSE_2.instantiate()
	course_2.connect("goIntoExit", _on_course_2_go_into_exit)
	add_child(course_2)

func _on_course_2_go_into_exit() -> void:
	$course2.queue_free()
	var course_3 = COURSE_3.instantiate()
	course_3.connect("goIntoExit", _on_course_2_go_into_exit)
	add_child(course_3)
