GDPC                 �                                                                          X   res://.godot/exported/133200997/export-3f70c87a425196c3103e353039ad1a60-menu_button.scn �<      �      櫂B�i&�,��'Q��    T   res://.godot/exported/133200997/export-44598c79a3e447ee8ebde156366fd9b0-fader.scn   0#      <      ς+��"+�d�Y�(�    X   res://.godot/exported/133200997/export-55f447ec2e7b2ee0ae5d47d7bc840026-pause_menu.scn  �0      �
      \n>�h[��CnZM�    X   res://.godot/exported/133200997/export-7ddb2f31ac7f567bd1eeadc4f3b20fb8-ui_manager.scn  �      x      L���.����,����    P   res://.godot/exported/133200997/export-be38ce8e8119a29546377ef321fb5b05-main.scn�      �      O�y6�������L�>{    X   res://.godot/exported/133200997/export-c06f25764a06ba9f0130370d778d1eac-main_menu.scn    I      Y      e+�*�.#���q
b�    \   res://.godot/exported/133200997/export-e826e0147ef8fa808558500ba6267943-scene_manager.scn   @      �      B�U��&4��iÑ�    X   res://.godot/exported/133200997/export-efc50245c1f609c2a3000d9121f2224c-intro_screen.scn @      �      / ?.�K��/u�(1�    ,   res://.godot/global_script_class_cache.cfg          �       �8��XΧ2-�xtH|X    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�O      ^      2��r3��MgB�[79       res://.godot/uid_cache.bin  �q      �      <m*�~I�u����C[��    0   res://autoload/scene_manager/scene_manager.gd   �       �      HaEKV���!��V�/��    8   res://autoload/scene_manager/scene_manager.tscn.remap   �]      j       [<Ƽ���1#
��k|    (   res://autoload/ui_manager/ui_manager.gd �      �      ���4�\��>cca�    0   res://autoload/ui_manager/ui_manager.tscn.remap  ^      g       s
@֡�Ü*��*28�       res://common/main/main.gd   @      �       aFr�_=}���SH�k    $   res://common/main/main.tscn.remap   �^      a       g-/$��O�C'� �r    $   res://common/shaders/blur.gdshader  `            C�qY�����Ζٲn    (   res://common/shaders/outline.gdshader   �      �      �G���i"��d���s�       res://gui/base_ui.gd;      w      ��!M��lٽ���6e       res://gui/fader/fader.gdP"      �       N�bm�l{	j�� �J~u        res://gui/fader/fader.tscn.remap _      b       �;�	6M�Cyq܀��X�        res://gui/menu_button.tscn.remap�_      h       5��ت�x�	�����    $   res://gui/pause_menu/pause_menu.gd  p+            3��Vς�_`�����    ,   res://gui/pause_menu/pause_menu.tscn.remap  p_      g       Z���6k(���       res://icon.svg  0a      N      ]��s�9^w/�����       res://icon.svg.import   �\      �       ƒk+��Sў�����       res://project.binary s      F      ����`�9��aC?"    ,   res://scenes/intro_screen/intro_screen.gd   @?      �       �����υy/�K�3�    4   res://scenes/intro_screen/intro_screen.tscn.remap   P`      i       �p�m��<{���    $   res://scenes/main_menu/main_menu.gd  H            �7��L;h��c���~�Y    ,   res://scenes/main_menu/main_menu.tscn.remap �`      f       M������;����    m�b list=Array[Dictionary]([{
"base": &"Control",
"class": &"BaseUI",
"icon": "",
"language": &"GDScript",
"path": "res://gui/base_ui.gd"
}])
����extends Node2D

@onready var scenes: Dictionary = {
	"intro_screen": preload("res://scenes/intro_screen/intro_screen.tscn"),
	"main_menu": preload("res://scenes/main_menu/main_menu.tscn"),
	# "level": preload("res://scenes/gameplay/gameplay_scene.tscn"),
}

@onready var screen: Viewport = get_node("/root/main/screen_container/screen")

signal scene_changed

var current_scene: String

func change_scene(scene_name: String) -> void:
	var fader: BaseUI = UIManager.open_ui("fader")
	var fader_animator: AnimationPlayer = fader.get_node("animator")
	var old_scene = get_tree().current_scene
	await fader_animator.animation_finished
	for child in screen.get_children():
		screen.remove_child(child)
	var instanced_scene = scenes[scene_name].instantiate()
	screen.add_child(instanced_scene)
	UIManager.close_ui("fader")
	current_scene = scene_name
	await fader_animator.animation_finished
	scene_changed.emit(old_scene, scene_name)
����(�M�s���:RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script .   res://autoload/scene_manager/scene_manager.gd ��������      local://PackedScene_4r50h %         PackedScene          	         names "         scene_manager    script    Node2D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRCextends Control

@onready var gui: CanvasLayer = $gui

@onready var uis: Dictionary = {
	"fader": preload("res://gui/fader/fader.tscn"),
	"pause_menu": preload("res://gui/pause_menu/pause_menu.tscn"),
}

var active_uis: Array
var inactive_uis: Array
var instanced_uis: Dictionary
var current_ui: BaseUI

func open_ui(ui_name: String, re_instance: bool = false) -> BaseUI:
	var ui: BaseUI = null
	if re_instance:
		free_ui(ui_name)
		ui = instance_ui(ui_name)
	else:
		ui = get_ui(ui_name)
	current_ui = ui
	ui.open()
	if not active_uis.has(ui):
		active_uis.append(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	return ui

func close_ui(ui_name: String, free: bool = false) -> BaseUI:
	if not uis.has(ui_name):
		return null
	var ui: BaseUI = instanced_uis[ui_name]
	ui.close()
	if not inactive_uis.has(ui):
		inactive_uis.append(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if free:
		free_ui(ui_name)
		return null
	current_ui = active_uis[-1] if len(active_uis) > 0 else null
	return ui

func get_ui(ui_name: String) -> BaseUI:
	if not uis.has(ui_name):
		return null
	if not instanced_uis.has(ui_name):
		instance_ui(ui_name)
	var ui: BaseUI = instanced_uis[ui_name]
	return ui

func instance_ui(ui_name: String, start_open = false) -> BaseUI:
	if not uis.has(ui_name):
		return null
	var instanced_ui: BaseUI = uis[ui_name].instantiate()
	instanced_ui.name = ui_name
	instanced_uis[ui_name] = instanced_ui
	gui.add_child(instanced_ui)
	if not start_open:
		instanced_ui.hide()
	return instanced_ui

func free_ui(ui_name: String) -> void:
	if not uis.has(ui_name):
		return
	var ui: BaseUI = instanced_uis[ui_name]
	instanced_uis.erase(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	ui.queue_free()
RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script (   res://autoload/ui_manager/ui_manager.gd ��������      local://PackedScene_m2r6y          PackedScene          	         names "         ui_manager    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    gui    CanvasLayer    	   variants                        �?                      node_count             nodes        ��������       ����                                                          
   	   ����              conn_count              conns               node_paths              editable_instances              version             RSRC��<Ff�ȗextends Control

@onready var screen: SubViewport = $screen_container/screen

#func _input(event: InputEvent) -> void:
#	screen.input(event)
Ek3RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://common/main/main.gd ��������   PackedScene ,   res://scenes/intro_screen/intro_screen.tscn �p�j��2      local://PackedScene_kb8wi Y         PackedScene          	         names "         main    layout_mode    anchors_preset    script    Control    screen_container    offset_right    offset_bottom    SubViewportContainer    screen    disable_3d    handle_input_locally    size    render_target_update_mode    SubViewport    intro_screen    	   variants    	                                B             -   �                         node_count             nodes     0   ��������       ����                                        ����                                   	   ����   
                                   ���                    conn_count              conns               node_paths              editable_instances              version             RSRCQ// Implementation of Gaussian blur
shader_type canvas_item;

// Standard deviation of Gaussian function
const float sigma = 1.5;

// Size of Gaussian kernel
uniform float blur_radius: hint_range(1, 15) = 5;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

// Calculates the Gaussian of the given x and y
float gaussian(float x, float y)
{
	float sigma_squared = sigma * sigma;
	float amplitude = 1.0 / (TAU * sigma_squared);
	float exponent = -((x * x) + (y * y)) / (2.0 * sigma_squared);
	return amplitude * pow(E, exponent);
}

vec4 blur13(sampler2D image, vec2 uv, vec2 resolution, vec2 direction) {
	vec4 color = vec4(0.0);
	vec2 off1 = vec2(1.411764705882353) * direction;
	vec2 off2 = vec2(3.2941176470588234) * direction;
	vec2 off3 = vec2(5.176470588235294) * direction;
	color += texture(image, uv) * 0.1964825501511404;
	color += texture(image, clamp(uv + (off1 / resolution), vec2(0), vec2(1))) * 0.2969069646728344;
	color += texture(image, clamp(uv - (off1 / resolution), vec2(0), vec2(1))) * 0.2969069646728344;
	color += texture(image, clamp(uv + (off2 / resolution), vec2(0), vec2(1))) * 0.09447039785044732;
	color += texture(image, clamp(uv - (off2 / resolution), vec2(0), vec2(1))) * 0.09447039785044732;
	color += texture(image, clamp(uv + (off3 / resolution), vec2(0), vec2(1))) * 0.010381362401148057;
	color += texture(image, clamp(uv - (off3 / resolution), vec2(0), vec2(1))) * 0.010381362401148057;
	return color;
}

void fragment() 
{
	float total_weight = 0.0;
	vec4 color = vec4(0.0);

	for (float x = -(blur_radius - 1.0) / 2.0; x <= (blur_radius - 1.0) / 2.0; x++)
	{
		for (float y = -(blur_radius - 1.0) / 2.0; y <= (blur_radius - 1.0) / 2.0; y++)
		{
			vec2 uv = vec2(SCREEN_UV.x + (x * TEXTURE_PIXEL_SIZE.x), SCREEN_UV.y + (y * TEXTURE_PIXEL_SIZE.y));
			float weight = gaussian(uv.x, uv.y);
			vec4 pixel_color = texture(screen_texture, uv);
			total_weight += weight;
			color += pixel_color * weight;
		}
	}

	COLOR = color / total_weight;
//	COLOR = blur13(TEXTURE, UV, vec2(1024, 600), vec2(1, 1));
}�����	Ǆ��shader_type canvas_item;

uniform vec4 line_color: source_color = vec4(1.0);
uniform float line_thickness: hint_range(0, 25) = 1.0;

void fragment()
{
	vec4 color = texture(TEXTURE, UV);

	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness / 2.0;

	float l = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	float u = texture(TEXTURE, UV + vec2(0, size.y)).a;
	float r = texture(TEXTURE, UV + vec2(size.x, 0)).a;
	float d = texture(TEXTURE, UV + vec2(0, -size.y)).a;
	float lu = texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	float ru = texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	float ld = texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	float rd = texture(TEXTURE, UV + vec2(size.x, -size.y)).a;

	float outline = min(1.0, l+r+u+d+lu+ru+ld+rd) - color.a;
	float inline = (1.0 - l * r * u * d * lu * ru * rd * ld) * color.a;

	vec4 outlined_result = mix(color, line_color, outline + inline);
	// Outline color
	COLOR = mix(color, outlined_result, outlined_result.a);
}Z_��PMextends BaseUI

@onready var animator: AnimationPlayer = $animator

func open() -> void:
	super.open()
	animator.play("show")
	
func close() -> void:
	animator.play("hide")
	await animator.animation_finished
	super.close()
 RSRC                     PackedScene            ��������                                                  fader_rect    color    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    script    _data 	   _bundled       Script    res://gui/fader/fader.gd ��������      local://Animation_uhtyq T         local://Animation_yuw0q �         local://AnimationLibrary_hh2pj �         local://PackedScene_se8pv       
   Animation 
            hide          ?         value           	         
                                                times !             ?      transitions !        �?  �?      values                        �?                         update              
   Animation 
            show          ?         value           	         
                                                times !             ?      transitions !        �?  �?      values                                           �?      update                 AnimationLibrary                   hide                 show                   PackedScene          	         names "         fader    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator 
   libraries    AnimationPlayer    fader_rect    color 
   ColorRect    	   variants                        �?                                                             �?      node_count             nodes     3   ��������       ����                                                             	   ����   
                        ����                                                       conn_count              conns               node_paths              editable_instances              version             RSRCl3��extends BaseUI

@onready var animator: AnimationPlayer = $animator
@onready var background_blur: TextureRect = $background_blur
@onready var margin_container: MarginContainer = $margin_container
@onready var menu_buttons: VBoxContainer = margin_container.get_node("menu_buttons")
@onready var quit_warning: VBoxContainer = margin_container.get_node("quit_warning")

var can_close: bool

func _ready() -> void:
	background_blur.texture = get_viewport().get_texture()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_open:
			close()
		else:
			open()
			
func open() -> void:
	super.open()
	animator.play("open")
	
func close() -> void:
	animator.play("close")
	
func pause(do_pause: bool = true) -> void:
	get_tree().set_pause(do_pause)

func _on_animator_animation_finished(anim_name: String) -> void:
	if anim_name == "open":
		can_close = true
	elif anim_name == "close":
		super.close()

func _on_resume_button_pressed() -> void:
	close()

func _on_settings_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	menu_buttons.hide()
	quit_warning.show()

func _on_quit_confirm_pressed() -> void:
	close()
	SceneManager.change_scene("main_menu")

func _on_quit_cancel_pressed() -> void:
	quit_warning.hide()
	menu_buttons.show()
�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script #   res://gui/pause_menu/pause_menu.gd ��������   PackedScene    res://gui/menu_button.tscn ���7���      local://PackedScene_0lpq7 Q         PackedScene          	         names "   -      pause_menu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator    AnimationPlayer    background_blur    TextureRect    margin_container %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    MarginContainer    menu_buttons 
   alignment    VBoxContainer    resume_button    text    settings_button    quit_button    quit_warning    visible $   theme_override_constants/separation    size_flags_vertical    bbcode_enabled    RichTextLabel    center_container    size_flags_horizontal    CenterContainer    quit_buttons    HBoxContainer    quit_confirm    quit_cancel    _on_resume_button_pressed    pressed    _on_settings_button_pressed    _on_quit_button_pressed    _on_quit_confirm_pressed    _on_quit_cancel_pressed    	   variants                        �?                                @                  Resume    	   Settings       Quit                 0   [center]Are you sure you want to quit?[/center]       Yes       No       node_count             nodes     �   ��������       ����                                                          
   	   ����                      ����                                                         ����
                                                                                ����                          ���                  	              ���                  
              ���                                      ����                                      ����                                       "       ����         !           
       $   #   ����                          ���%                                ���&                               conn_count             conns     #          (   '                     (   )                     (   *                     (   +                     (   ,                    node_paths              editable_instances              version             RSRC�߭��W9.�@extends Control
class_name BaseUI

signal opened(ui)
signal closed(ui)

var is_open: bool

func _ready() -> void:
	connect("visibility_changed", _on_visibility_changed)

func open() -> void:
	show()
	opened.emit(self)
	is_open = true

func close() -> void:
	hide()
	closed.emit(self)
	is_open = false

func _on_visibility_changed() -> void:
	if visible:
		pass
	else:
		pass
��(��kRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_sh2c5 �          PackedScene          	         names "         menu_button    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Button    	   variants            �?            node_count             nodes        ��������       ����                                       conn_count              conns               node_paths              editable_instances              version             RSRC9��|dH�e�w�textends Control

@onready var animator: AnimationPlayer = $animator

func _ready() -> void:
	animator.play("start")
	await animator.animation_finished
	SceneManager.change_scene("main_menu")
�RSRC                     PackedScene            ��������                                                  center_container    logo 	   modulate    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    script    _data 	   _bundled       Script *   res://scenes/intro_screen/intro_screen.gd ��������
   Texture2D    res://icon.svg �P�s��T      local://Animation_s7hqo |         local://AnimationLibrary_m66px �         local://PackedScene_sp2wf �      
   Animation 
            start       
�#<         value 	          
                                                            times !            �>      transitions !        �?  �?      values            �?  �?  �?         �?  �?  �?  �?      update                 AnimationLibrary                   start                    PackedScene          	         names "         intro_screen    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator 
   libraries    AnimationPlayer    background    color 
   ColorRect    center_container    CenterContainer    logo    texture    TextureRect    	   variants    	                    �?                                                             �?               node_count             nodes     Q   ��������       ����                                                             	   ����   
                        ����                                                               ����                                                        ����                         conn_count              conns               node_paths              editable_instances              version             RSRC�K�ѐ��extends Control

func _ready() -> void:
	if UIManager.get_ui("pause_menu") != null:
		UIManager.free_ui("pause_menu")

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("level")
QFB��\5fRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script $   res://scenes/main_menu/main_menu.gd ��������   PackedScene    res://gui/menu_button.tscn ���7���      local://PackedScene_7uls5 R         PackedScene          	         names "      
   main_menu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator    AnimationPlayer    margin_container %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    MarginContainer    menu_buttons 
   alignment    VBoxContainer    start_button    text    settings_button    _on_start_button_pressed    pressed    	   variants                        �?                                @                  Start    	   Settings       node_count             nodes     X   ��������       ����                                                          
   	   ����                      ����
                                                                                ����                          ���                  	              ���                  
             conn_count             conns                                      node_paths              editable_instances              version             RSRCx���GST2   �   �      ����               � �        &  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�4mb�h3O���$E�s����A*DV�:#�)��)�X/�x�>@\�0|�q��m֋�d�0ψ�t�!&����P2Z�z��QF+9ʿ�d0��VɬF�F� ���A�����j4BUHp�AI�r��ِ���27ݵ<�=g��9�1�e"e�{�(�(m�`Ec\]�%��nkFC��d���7<�
V�Lĩ>���Qo�<`�M�$x���jD�BfY3�37�W��%�ݠ�5�Au����WpeU+.v�mj��%' ��ħp�6S�� q��M�׌F�n��w�$$�VI��o�l��m)��Du!SZ��V@9ד]��b=�P3�D��bSU�9�B���zQmY�M~�M<��Er�8��F)�?@`�:7�=��1I]�������3�٭!'��Jn�GS���0&��;�bE�
�
5[I��=i�/��%�̘@�YYL���J�kKvX���S���	�ڊW_�溶�R���S��I��`��?֩�Z�T^]1��VsU#f���i��1�Ivh!9+�VZ�Mr�טP�~|"/���IK
g`��MK�����|CҴ�ZQs���fvƄ0e�NN�F-���FNG)��W�2�JN	��������ܕ����2
�~�y#cB���1�YϮ�h�9����m������v��`g����]1�)�F�^^]Rץ�f��Tk� s�SP�7L�_Y�x�ŤiC�X]��r�>e:	{Sm�ĒT��ubN����k�Yb�;��Eߝ�m�Us�q��1�(\�����Ӈ�b(�7�"�Yme�WY!-)�L���L�6ie��@�Z3D\?��\W�c"e���4��AǘH���L�`L�M��G$𩫅�W���FY�gL$NI�'������I]�r��ܜ��`W<ߛe6ߛ�I>v���W�!a��������M3���IV��]�yhBҴFlr�!8Մ�^Ҷ�㒸5����I#�I�ڦ���P2R���(�r�a߰z����G~����w�=C�2������C��{�hWl%��и���O������;0*��`��U��R��vw�� (7�T#�Ƨ�o7�
�xk͍\dq3a��	x p�ȥ�3>Wc�� �	��7�kI��9F}�ID
�B���
��v<�vjQ�:a�J�5L&�F�{l��Rh����I��F�鳁P�Nc�w:17��f}u}�Κu@��`� @�������8@`�
�1 ��j#`[�)�8`���vh�p� P���׷�>����"@<�����sv� ����"�Q@,�A��P8��dp{�B��r��X��3��n$�^ ��������^B9��n����0T�m�2�ka9!�2!���]
?p ZA$\S��~B�O ��;��-|��
{�V��:���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���(�#2:E(*�H���{��>��&!��$| �~�+\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j����	P:�~�G0 �J��$�M���@�Q��Yz��i��~q�1?�c��Bߝϟ�n�*������8j������p���ox���"w���r�yvz U\F8��<E��xz�i���qi����ȴ�ݷ-r`\�6����Y��q^�Lx�9���#���m����-F�F.-�a�;6��lE�Q��)�P�x�:-�_E�4~v��Z�����䷳�:�n��,㛵��m�=wz�Ξ;2-��[k~v��Ӹ_G�%*�i� ����{�%;����m��g�ez.3���{�����Kv���s �fZ!:� 4W��޵D��U��
(t}�]5�ݫ߉�~|z��أ�#%���ѝ܏x�D4�4^_�1�g���<��!����t�oV�lm�s(EK͕��K�����n���Ӌ���&�̝M�&rs�0��q��Z��GUo�]'G�X�E����;����=Ɲ�f��_0�ߝfw�!E����A[;���ڕ�^�W"���s5֚?�=�+9@��j������b���VZ^�ltp��f+����Z�6��j�`�L��Za�I��N�0W���Z����:g��WWjs�#�Y��"�k5m�_���sh\���F%p䬵�6������\h2lNs�V��#�t�� }�K���Kvzs�>9>�l�+�>��^�n����~Ěg���e~%�w6ɓ������y��h�DC���b�KG-�d��__'0�{�7����&��yFD�2j~�����ټ�_��0�#��y�9��P�?���������f�fj6͙��r�V�K�{[ͮ�;4)O/��az{�<><__����G����[�0���v��G?e��������:���١I���z�M�Wۋ�x���������u�/��]1=��s��E&�q�l�-P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸z��f��i���_�j�S-|��w�J�<LծT��-9�����I�®�6 *3��y�[�.Ԗ�K��J���<�ݿ��-t�J���E�63���1R��}Ғbꨝט�l?�#���ӴQ��.�S���U
v�&�3�&O���0�9-�O�kK��V_gn��k��U_k˂�4�9�v�I�:;�w&��Q�ҍ�
��fG��B��-����ÇpNk�sZM�s���*��g8��-���V`b����H���
3cU'0hR
�w�XŁ�K݊�MV]�} o�w�tJJ���$꜁x$��l$>�F�EF�޺�G�j�#�G�t�bjj�F�б��q:�`O�4�y�8`Av<�x`��&I[��'A�˚�5��KAn��jx ��=Kn@��t����)�9��=�ݷ�tI��d\�M�j�B�${��G����VX�V6��f�#��V�wk ��W�8�	����lCDZ���ϖ@���X��x�W�Utq�ii�D($�X��Z'8Ay@�s�<�x͡�PU"rB�Q�_�Q6  2�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctbubyd7jexb1"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 '������do������[remap]

path="res://.godot/exported/133200997/export-e826e0147ef8fa808558500ba6267943-scene_manager.scn"
�f�O�T[remap]

path="res://.godot/exported/133200997/export-7ddb2f31ac7f567bd1eeadc4f3b20fb8-ui_manager.scn"
�Նe����$[remap]

path="res://.godot/exported/133200997/export-be38ce8e8119a29546377ef321fb5b05-main.scn"
4�2�>l�aC�ބ z[remap]

path="res://.godot/exported/133200997/export-44598c79a3e447ee8ebde156366fd9b0-fader.scn"
�˃/�-��X[remap]

path="res://.godot/exported/133200997/export-55f447ec2e7b2ee0ae5d47d7bc840026-pause_menu.scn"
D�}@9Q+�[remap]

path="res://.godot/exported/133200997/export-3f70c87a425196c3103e353039ad1a60-menu_button.scn"
�䗊���[remap]

path="res://.godot/exported/133200997/export-efc50245c1f609c2a3000d9121f2224c-intro_screen.scn"
�D@��;[remap]

path="res://.godot/exported/133200997/export-c06f25764a06ba9f0130370d778d1eac-main_menu.scn"
'N��o5�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><g transform="translate(32 32)"><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99z" fill="#363d52"/><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99zm0 4h96c6.64 0 12 5.35 12 11.99v95.98c0 6.64-5.35 11.99-12 11.99h-96c-6.64 0-12-5.35-12-11.99v-95.98c0-6.64 5.36-11.99 12-11.99z" fill-opacity=".4"/></g><g stroke-width="9.92746" transform="matrix(.10073078 0 0 .10073078 12.425923 2.256365)"><path d="m0 0s-.325 1.994-.515 1.976l-36.182-3.491c-2.879-.278-5.115-2.574-5.317-5.459l-.994-14.247-27.992-1.997-1.904 12.912c-.424 2.872-2.932 5.037-5.835 5.037h-38.188c-2.902 0-5.41-2.165-5.834-5.037l-1.905-12.912-27.992 1.997-.994 14.247c-.202 2.886-2.438 5.182-5.317 5.46l-36.2 3.49c-.187.018-.324-1.978-.511-1.978l-.049-7.83 30.658-4.944 1.004-14.374c.203-2.91 2.551-5.263 5.463-5.472l38.551-2.75c.146-.01.29-.016.434-.016 2.897 0 5.401 2.166 5.825 5.038l1.959 13.286h28.005l1.959-13.286c.423-2.871 2.93-5.037 5.831-5.037.142 0 .284.005.423.015l38.556 2.75c2.911.209 5.26 2.562 5.463 5.472l1.003 14.374 30.645 4.966z" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 919.24059 771.67186)"/><path d="m0 0v-47.514-6.035-5.492c.108-.001.216-.005.323-.015l36.196-3.49c1.896-.183 3.382-1.709 3.514-3.609l1.116-15.978 31.574-2.253 2.175 14.747c.282 1.912 1.922 3.329 3.856 3.329h38.188c1.933 0 3.573-1.417 3.855-3.329l2.175-14.747 31.575 2.253 1.115 15.978c.133 1.9 1.618 3.425 3.514 3.609l36.182 3.49c.107.01.214.014.322.015v4.711l.015.005v54.325c5.09692 6.4164715 9.92323 13.494208 13.621 19.449-5.651 9.62-12.575 18.217-19.976 26.182-6.864-3.455-13.531-7.369-19.828-11.534-3.151 3.132-6.7 5.694-10.186 8.372-3.425 2.751-7.285 4.768-10.946 7.118 1.09 8.117 1.629 16.108 1.846 24.448-9.446 4.754-19.519 7.906-29.708 10.17-4.068-6.837-7.788-14.241-11.028-21.479-3.842.642-7.702.88-11.567.926v.006c-.027 0-.052-.006-.075-.006-.024 0-.049.006-.073.006v-.006c-3.872-.046-7.729-.284-11.572-.926-3.238 7.238-6.956 14.642-11.03 21.479-10.184-2.264-20.258-5.416-29.703-10.17.216-8.34.755-16.331 1.848-24.448-3.668-2.35-7.523-4.367-10.949-7.118-3.481-2.678-7.036-5.24-10.188-8.372-6.297 4.165-12.962 8.079-19.828 11.534-7.401-7.965-14.321-16.562-19.974-26.182 4.4426579-6.973692 9.2079702-13.9828876 13.621-19.449z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 104.69892 525.90697)"/><path d="m0 0-1.121-16.063c-.135-1.936-1.675-3.477-3.611-3.616l-38.555-2.751c-.094-.007-.188-.01-.281-.01-1.916 0-3.569 1.406-3.852 3.33l-2.211 14.994h-31.459l-2.211-14.994c-.297-2.018-2.101-3.469-4.133-3.32l-38.555 2.751c-1.936.139-3.476 1.68-3.611 3.616l-1.121 16.063-32.547 3.138c.015-3.498.06-7.33.06-8.093 0-34.374 43.605-50.896 97.781-51.086h.066.067c54.176.19 97.766 16.712 97.766 51.086 0 .777.047 4.593.063 8.093z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 784.07144 817.24284)"/><path d="m0 0c0-12.052-9.765-21.815-21.813-21.815-12.042 0-21.81 9.763-21.81 21.815 0 12.044 9.768 21.802 21.81 21.802 12.048 0 21.813-9.758 21.813-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 389.21484 625.67104)"/><path d="m0 0c0-7.994-6.479-14.473-14.479-14.473-7.996 0-14.479 6.479-14.479 14.473s6.483 14.479 14.479 14.479c8 0 14.479-6.485 14.479-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 367.36686 631.05679)"/><path d="m0 0c-3.878 0-7.021 2.858-7.021 6.381v20.081c0 3.52 3.143 6.381 7.021 6.381s7.028-2.861 7.028-6.381v-20.081c0-3.523-3.15-6.381-7.028-6.381" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 511.99336 724.73954)"/><path d="m0 0c0-12.052 9.765-21.815 21.815-21.815 12.041 0 21.808 9.763 21.808 21.815 0 12.044-9.767 21.802-21.808 21.802-12.05 0-21.815-9.758-21.815-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 634.78706 625.67104)"/><path d="m0 0c0-7.994 6.477-14.473 14.471-14.473 8.002 0 14.479 6.479 14.479 14.473s-6.477 14.479-14.479 14.479c-7.994 0-14.471-6.485-14.471-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 656.64056 631.05679)"/></g></svg>
�$	   4��2/`/   res://autoload/scene_manager/scene_manager.tscn��r�c#)   res://autoload/ui_manager/ui_manager.tscn��bO=�F   res://common/main/main.tscnyh�AD   res://gui/fader/fader.tscn��+1��i>$   res://gui/pause_menu/pause_menu.tscn���7���   res://gui/menu_button.tscn�p�j��2+   res://scenes/intro_screen/intro_screen.tscn�,�(��%   res://scenes/main_menu/main_menu.tscn�P�s��T   res://icon.svg�3�2�ECFG      application/config/name         Game Template      application/run/main_scene$         res://common/main/main.tscn    application/config/features(   "         4.0    GL Compatibility        application/boot_splash/bg_color                    �?"   application/boot_splash/show_image             application/config/icon         res://icon.svg     autoload/UIManager4      *   *res://autoload/ui_manager/ui_manager.tscn     autoload/SceneManager8      0   *res://autoload/scene_manager/scene_manager.tscn"   display/window/size/viewport_width      �  #   display/window/size/viewport_height           dotnet/project/assembly_name         Game Template   #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility�m��7�w6%