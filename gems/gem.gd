extends StaticBody2D

const PROJ = preload('res://projectiles/projectile.tscn')

onready var projectiles = get_node('/root/Global').get_main().get_node('Projectiles')
onready var timer = get_node('Timer')
onready var gem_colors = preload('res://gems/gem_colors.gd')

var tower

func _ready():
	timer.connect('timeout', self, '_on_Timer_timeout')
	self.input_pickable = true

func _on_Timer_timeout():
	shoot()

func shoot():
	tower = get_parent()
	if tower.is_in_group('tower') and tower.nearby_creeps.size() > 0:
		var proj = PROJ.instance()
		var _gem_colors = gem_colors.new()
		proj.position = tower.position
		proj.creep = tower.nearby_creeps[0]
		proj.modulate = _gem_colors.get_gem_color(self.name)
		tower.nearby_creeps[0].projectiles.append(proj)
		projectiles.add_child(proj)
		timer.start()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_select'):
		timer.stop()