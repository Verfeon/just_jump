extends ProgressBar

const BORDER_WIDTH = 1
const BORDER_COLOR = Color.BLACK
	

func _ready():
	value_changed.connect(func(_v): queue_redraw())

func _draw():
	# Calculer la largeur du fill en fonction de la valeur
	var fill_ratio = clamp((value - min_value) / (max_value - min_value), 0.0, 1.0)
	var fill_width = size.x * fill_ratio
	
	# Dessiner le contour autour du fill uniquement
	if fill_width > BORDER_WIDTH * 2:  # S'assurer qu'il y a assez de place
		var fill_rect = Rect2(0, 0, fill_width, size.y)
		draw_rect(fill_rect, BORDER_COLOR, false, BORDER_WIDTH)


func update_bar_color(t: float):
	var color = Color(0, 1, 0).lerp(Color(1, 0, 0), t)  # vert → rouge
	set_bar_color(color)

func set_bar_color(color: Color):
	var gradient = Gradient.new()
	gradient.remove_point(0)
	gradient.add_point(0.0, Color(0, 1, 0))
	gradient.remove_point(0)
	gradient.add_point(1.0, color)
	gradient.add_point(0.5, color + Color(0, 1, 0))
	
	var grad_texture = GradientTexture1D.new()
	grad_texture.gradient = gradient
	
	var style = StyleBoxTexture.new()
	style.texture = grad_texture
	
	add_theme_stylebox_override("fill", style)
	
	# Redessiner pour mettre à jour le contour
	queue_redraw()
