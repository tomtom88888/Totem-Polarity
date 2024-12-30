extends Node2D

@export var level_to_course_dict = {
	0: [preload("res://levels/0/0_course_1.tscn"), preload("res://levels/0/0_course_2.tscn"), preload("res://levels/0/0_course_3.tscn")],
	1: [preload("res://levels/0/0_course_1.tscn"), preload("res://levels/0/0_course_2.tscn"), preload("res://levels/0/0_course_3.tscn")],
}
const COURSE_01 = preload("res://levels/0/0_course_1.tscn")
const COURSE_02 = preload("res://levels/0/0_course_2.tscn")
const COURSE_03 = preload("res://levels/0/0_course_3.tscn")
var active_course
var current_course
func _ready() -> void:
	active_course = 1
	get_child(0).connect("goIntoExit", Callable(self, "go_into_exit"))

func test():
	print("test")

func _process(delta: float) -> void:
	pass

func reload_current_course():
	print("fuck")
	get_child(0).queue_free()
	print(level_to_course_dict[LevelData.level][active_course - 1].instantiate())
	current_course = level_to_course_dict[LevelData.level][active_course - 1].instantiate()
	current_course.connect("goIntoExit", Callable(self, "go_into_exit"))
	add_child(current_course)

func go_into_exit():
	if active_course < len(level_to_course_dict[LevelData.level]):
		get_child(0).queue_free()
		current_course = level_to_course_dict[LevelData.level][active_course].instantiate()
		current_course.connect("goIntoExit", Callable(self, "go_into_exit"))
		active_course += 1
		add_child(current_course)
	else:
		finished_level()

func finished_level():
	get_parent().switch_scene(preload("res://scenes/win.tscn"))
