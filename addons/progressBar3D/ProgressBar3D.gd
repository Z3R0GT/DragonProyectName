@tool

class_name ProgressBar3D extends Node3D


var percent_full: float
@onready var origin: Node3D
@onready var under: MeshInstance3D
@onready var progress: MeshInstance3D



func _init():
	origin = Node3D.new()
	under = MeshInstance3D.new()
	progress = MeshInstance3D.new()

	add_child(origin)

	origin.add_child(under)
	origin.add_child(progress)

	under.mesh = BoxMesh.new()
	progress.mesh = BoxMesh.new()

	under.material_override = StandardMaterial3D.new()
	progress.material_override = StandardMaterial3D.new()


	set_percent_full()
	set_mesh_sizes()
	set_under_color()
	set_progress_color()

	under.material_override.billboard_mode = billboard
	progress.material_override.billboard_mode = billboard

	under.material_override.shading_mode = shaded
	progress.material_override.shading_mode = shaded



	
@export var min_value = 0.0:
	set(val):
		min_value = val
		set_percent_full()
		set_mesh_sizes()
		set_progress_color()

@export var max_value = 1.0:
	set(val):
		max_value = val
		set_percent_full()
		set_mesh_sizes()
		set_progress_color()

@export var value = 1.0:
	set(val):
		value = val
		if max_value == 0:
			print("Ensure Max Value is not 0 and avoid a deadly divide-by-zero error!")
			return

		set_percent_full()
		set_mesh_sizes()
		set_progress_color()

		
	
@export var empty_color = Color.RED:
	set(val):
		empty_color = val
		set_progress_color()

@export var full_color = Color.GREEN:
	set(val):
		full_color = val
		set_progress_color()


@export var outline_color = Color.BLACK:
	set(val):
		outline_color = val
		set_under_color()

@export var outline_size = 0.1:
	set(val):
		outline_size = val
		set_mesh_sizes()

@export var size = Vector3(2.0, 0.175, 0.05):
	set(val):
		size = val
		set_mesh_sizes()

@export var keep_empty_bar = false:
	set(val):
		keep_empty_bar = val
		set_mesh_sizes()


@export_enum("Disabled", "Enabled", "Y-Billboard") var billboard = 1:
	set(val):
		match val:
			0:
				billboard = StandardMaterial3D.BILLBOARD_DISABLED
				under.material_override.billboard_mode = billboard
				progress.material_override.billboard_mode = billboard
			1:
				billboard = StandardMaterial3D.BILLBOARD_ENABLED
				under.material_override.billboard_mode = billboard
				progress.material_override.billboard_mode = billboard
			2:
				billboard = StandardMaterial3D.BILLBOARD_FIXED_Y
				under.material_override.billboard_mode = billboard
				progress.material_override.billboard_mode = billboard



@export_enum("Disabled", "Per Pixel", "Per Vertex", "Max") var shaded = 0:
	set(val):
		match val:
			0:
				shaded = BaseMaterial3D.SHADING_MODE_UNSHADED
				under.material_override.shading_mode = shaded
				progress.material_override.shading_mode = shaded
			1:
				shaded = BaseMaterial3D.SHADING_MODE_PER_PIXEL
				under.material_override.shading_mode = shaded
				progress.material_override.shading_mode = shaded
			2:
				shaded = BaseMaterial3D.SHADING_MODE_PER_VERTEX
				under.material_override.shading_mode = shaded
				progress.material_override.shading_mode = shaded
			3:
				shaded = BaseMaterial3D.SHADING_MODE_MAX
				under.material_override.shading_mode = shaded
				progress.material_override.shading_mode = shaded






func set_percent_full():
	percent_full = clamp((value - min_value) / (max_value - min_value),
	0, 100)


func set_mesh_sizes():
	var outline_offset: float = max(outline_size, .01)
	var x_size_offset = size.x * percent_full

	progress.mesh.size = Vector3(clamp(x_size_offset, 0, size.x - outline_offset),
	size.y, size.z
	)

	if(!keep_empty_bar):
		under.mesh.size.y = size.y + outline_offset
		under.mesh.size.z = size.z - outline_offset
		under.mesh.size.x = clamp(x_size_offset + outline_offset, 0, size.x)
	else:
		under.mesh.size.y = size.y + outline_offset
		under.mesh.size.z = size.z - outline_offset
		under.mesh.size.x = size.x



func set_under_color():
	under.material_override.albedo_color = outline_color

func set_progress_color():
	progress.material_override.albedo_color = empty_color.lerp(full_color, value)
