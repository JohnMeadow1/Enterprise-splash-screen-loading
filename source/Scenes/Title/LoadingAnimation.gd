extends Sprite2D

var major_axis:= 32.0
var minor_axis:= 32.0
@onready var planet = $Planet
@onready var tail = $Planet/Tail

var t := 0.0
func _physics_process(delta):
	t += delta * 4.0
	planet.position = Vector2(major_axis * sin(t), minor_axis * cos(t))
	planet.rotation = planet.position.angle()
