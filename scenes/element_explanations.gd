extends VBoxContainer

@onready var strengths_label: RichTextLabel = $StrengthsMarginContainer/StrengthsLabel
@onready var weaknesses_label: RichTextLabel = $WeaknessesMarginContainer/WeaknessesLabel

var pyro_hovered = false
var hydro_hovered = false
var earth_hovered = false
var waned_hovered = false
var hovered_element = ElementData.NONE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_set_hovered_element()
	if hovered_element != ElementData.NONE:
		_set_strengths_text()
		_set_weaknesses_text()
	else:
		strengths_label.text = ""
		weaknesses_label.text = ""

func _set_hovered_element() -> void:
	if not waned_hovered:
		hovered_element = ElementData.NONE
		return
	if pyro_hovered and not hydro_hovered and not earth_hovered:
		hovered_element = ElementData.PYRO
		return
	if not pyro_hovered and hydro_hovered and not earth_hovered:
		hovered_element = ElementData.HYDRO
		return
	if not pyro_hovered and not hydro_hovered and earth_hovered:
		hovered_element = ElementData.EARTH
		return
	if pyro_hovered and hydro_hovered and not earth_hovered:
		hovered_element = ElementData.LIGHTNING
		return
	if pyro_hovered and not hydro_hovered and earth_hovered:
		hovered_element = ElementData.ALLOY
		return
	if not pyro_hovered and hydro_hovered and earth_hovered:
		hovered_element = ElementData.FLORA
		return
	if pyro_hovered and hydro_hovered and earth_hovered:
		hovered_element = ElementData.PRISMATIC
		return
	if not pyro_hovered and not hydro_hovered and not earth_hovered:
		hovered_element = ElementData.WANED
		return
	
	hovered_element = ElementData.NONE
	return

func _set_strengths_text() -> void:
	var strength_description = " deals double damage and receives half damage against "
	strengths_label.text = _generate_matchup_text(strength_description, ElementData.strengths[hovered_element])

func _set_weaknesses_text() -> void:
	var weakness_description = " deals half damage and receives double damage against "
	weaknesses_label.text = _generate_matchup_text(weakness_description, ElementData.weaknesses[hovered_element])
	
func _generate_matchup_text(custom_text: String, element_names: Array) -> String:
	var generated_text: String = (
		ElementData.int2str[hovered_element] + 
		custom_text + 
		ElementData.int2str[element_names[0]]
	)
	if len(element_names) > 1:
		generated_text += " and " + ElementData.int2str[element_names[1]]
	generated_text += "."
	return generated_text

func _on_pyro_circle_area_mouse_entered() -> void:
	pyro_hovered = true

func _on_pyro_circle_area_mouse_exited() -> void:
	pyro_hovered = false

func _on_hydro_circle_area_mouse_entered() -> void:
	hydro_hovered = true

func _on_hydro_circle_area_mouse_exited() -> void:
	hydro_hovered = false

func _on_earth_circle_area_mouse_entered() -> void:
	earth_hovered = true

func _on_earth_circle_area_mouse_exited() -> void:
	earth_hovered = false

func _on_waned_circle_area_mouse_entered() -> void:
	waned_hovered = true

func _on_waned_circle_area_mouse_exited() -> void:
	waned_hovered = false
