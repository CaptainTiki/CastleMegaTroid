extends Node3D
class_name DebugJumpIndicator

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var sprite_3d_2: Sprite3D = $Sprite3D2

func modulate(color : Color = Color.RED) -> void:
	sprite_3d.modulate = color
	sprite_3d_2.modulate = color
