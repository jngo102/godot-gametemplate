GDPC                 �                                                                      +   T   res://.godot/exported/133200997/export-087d785bf5027725196895bd45adeefe-player.scn  0      �      פjl�������èH�    X   res://.godot/exported/133200997/export-14114c379f76b1c04097459e2387a1e6-pause_menu.scn  �9      T      z5���sc̼���I��    X   res://.godot/exported/133200997/export-181dbcc3dd6a789c1134295f55411c07-test_level.scn  p,      �      �T������(��    X   res://.godot/exported/133200997/export-255f7d8b8f8914312e6e0cbb54f15538-base_level.scn  P            6�:q�	0���؁
?�    P   res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scnPL      �      �-%���6'X��kM�    \   res://.godot/exported/133200997/export-665cf148b2def68f9680438c20b962a6-scene_manager.scn   0      �      �Cޔ��7&��V/�    T   res://.godot/exported/133200997/export-b056546710644e3494421d9ef8e17783-fader.scn    /      =      �F�>���3�d1���    X   res://.godot/exported/133200997/export-b8f81b3416be30cf7c843e5bd7441b82-menu_button.scn @7      �      `/YPJi|�2��E��    X   res://.godot/exported/133200997/export-c9d4cdb98d2720f278f6e650c673ef49-main_menu.scn   p%      �      [o�T��j��l@�b    X   res://.godot/exported/133200997/export-d8a47e9d00b7401c2997ba1ae72757ba-intro_screen.scnp      �      [�~���pPvy\̳�    X   res://.godot/exported/133200997/export-d9f84698d1f40b895b805aa8f950c516-ui_manager.scn  �      �      ����T~
�v5�?�    T   res://.godot/exported/133200997/export-e83d57cb3ac7e250efcb42c792ae42ff-actor.scn               G�F*ⷘ'�l�H�t��    ,   res://.godot/global_script_class_cache.cfg                ���l� ۃ*���|    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�k      \      6(4�d=EQ�ǮVj,       res://.godot/uid_cache.bin  ��            )/���i?�X���       res://icon.svg  @      N      ]��s�9^w/�����       res://icon.svg.import   0y      �       ƒk+��Sў�����       res://project.binary��      �      �.r6+���Ttb5O    (   res://resources/shaders/blur.gdshader                C�qY�����Ζٲn    (   res://resources/shaders/outline.gdshader@	      �      �G���i"��d���s�    $   res://scenes/actors/actor.tscn.remap z      b       �8ɸd��;l��8���    (   res://scenes/actors/player.tscn.remap   pz      c       �akԑ>�V�,�e�n�    0   res://scenes/autoload/scene_manager.tscn.remap  �z      j       �|,yR����ۇ7�    ,   res://scenes/autoload/ui_manager.tscn.remap P{      g       ��zjQ�]�'U�?ϴ'�    ,   res://scenes/levels/base_level.tscn.remap   �{      g       �yȏ�k�x.��8�2    ,   res://scenes/levels/intro_screen.tscn.remap 0|      i       �v�hnx�i��IG	�    (   res://scenes/levels/main_menu.tscn.remap�|      f       �]� s�w�Y���f5j    ,   res://scenes/levels/test_level.tscn.remap   }      g       GFy��ʶY��zL>�       res://scenes/main.tscn.remap�~      a       
��������S8z�s        res://scenes/ui/fader.tscn.remap�}      b       &13��\�rŹQ�q4    (   res://scenes/ui/menu_button.tscn.remap  �}      h       �$�����+�#�|��    (   res://scenes/ui/pause_menu.tscn.remap   `~      g       q^�����s���r\�        res://scripts/actors/actor.gd   �P      :      ��'l4X����3��Xw"        res://scripts/actors/player.gd   T      N      >�+�a�В��Q    (   res://scripts/autoload/scene_manager.gd pU            ��j� ���)@��'�    $   res://scripts/autoload/ui_manager.gd�Y      �      ם�k�Ri��r�30    $   res://scripts/levels/base_level.gd  Pa      q       ��y����V���v�r    $   res://scripts/levels/intro_screen.gd�a      �       ��ߪ!��ٵ	(��    $   res://scripts/levels/main_menu.gd   �b            K� �|W� ��� �D�       res://scripts/main.gd   �k             �����U���J���*       res://scripts/ui/base_ui.gd �d      �       �E3&m�h`�>�����G       res://scripts/ui/fader.gd   �e      �       N�bm�l{	j�� �J~u        res://scripts/ui/pause_menu.gd  �f      7      3��}L�sy��m�    �@xlist=Array[Dictionary]([{
"base": &"CharacterBody2D",
"class": &"Actor",
"icon": "",
"language": &"GDScript",
"path": "res://scripts/actors/actor.gd"
}, {
"base": &"Control",
"class": &"BaseUI",
"icon": "",
"language": &"GDScript",
"path": "res://scripts/ui/base_ui.gd"
}])
�;6�{����5<// Implementation of Gaussian blur
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
}S*#��䇗�shader_type canvas_item;

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
}��=x�"RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://scripts/actors/actor.gd ��������
   Texture2D    res://icon.svg �P�s��T      local://RectangleShape2D_y07t1 �         local://PackedScene_sdbjx �         RectangleShape2D       
      C   C         PackedScene          	         names "         actor    script    CharacterBody2D 	   animator    AnimationPlayer    sprite    texture 	   Sprite2D 
   collision    shape    CollisionShape2D    	   variants                                          node_count             nodes     "   ��������       ����                            ����                      ����                     
      ����   	                conn_count              conns               node_paths              editable_instances              version             RSRCl���gʝ�@��RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://scenes/actors/actor.tscn \1{,G   Script    res://scripts/actors/player.gd ��������      local://PackedScene_fvbvi Q         PackedScene          
         names "         player    script 	   animator    sprite 
   collision    	   variants                                node_count             nodes     	   �����������    ����                   conn_count              conns               node_paths              editable_instances              base_scene              version             RSRC<EH���RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script (   res://scripts/autoload/scene_manager.gd ��������      local://PackedScene_dltvh          PackedScene          	         names "         scene_manager    script    Node2D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC�)wp��RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script %   res://scripts/autoload/ui_manager.gd ��������      local://PackedScene_irny4          PackedScene          	         names "         ui_manager    process_mode    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    gui    CanvasLayer    	   variants                        �?                      node_count             nodes        ��������	       ����                                                                    
   ����              conn_count              conns               node_paths              editable_instances              version             RSRC�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script #   res://scripts/levels/base_level.gd ��������   PackedScene     res://scenes/actors/player.tscn 5�$�
ji      local://PackedScene_owuat V         PackedScene          	         names "         base_level    script    Node2D    player 	   position    	   variants                          
     TC  �C      node_count             nodes        ��������       ����                      ���                         conn_count              conns               node_paths              editable_instances              version             RSRCV
	���}S$��uRSRC                     PackedScene            ��������                                                  center_container    logo 	   modulate    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    script    _data 	   _bundled       Script %   res://scripts/levels/intro_screen.gd ��������
   Texture2D    res://icon.svg �P�s��T      local://Animation_s7hqo w         local://AnimationLibrary_m66px �         local://PackedScene_8w5p8 �      
   Animation 
            start       
�#<         value 	          
                                                            times !            �>      transitions !        �?  �?      values            �?  �?  �?         �?  �?  �?  �?      update                 AnimationLibrary                   start                    PackedScene          	         names "         intro_screen    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator 
   libraries    AnimationPlayer    background    color 
   ColorRect    center_container    CenterContainer    logo    texture    TextureRect    	   variants    	                    �?                                                             �?               node_count             nodes     Q   ��������       ����                                                             	   ����   
                        ����                                                               ����                                                        ����                         conn_count              conns               node_paths              editable_instances              version             RSRCǊȂ�R��o��RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script "   res://scripts/levels/main_menu.gd ��������   PackedScene !   res://scenes/ui/menu_button.tscn ���7���      local://PackedScene_epvps V         PackedScene          	         names "      
   main_menu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator    AnimationPlayer    margin_container %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    MarginContainer    menu_buttons 
   alignment    VBoxContainer    start_button    text    settings_button    quit_button    visible    _on_start_button_pressed    pressed    _on_quit_button_pressed    	   variants                        �?                                @                  Start    	   Settings              Quit       node_count             nodes     e   ��������       ����                                                          
   	   ����                      ����
                                                                                ����                          ���                  	              ���                  
              ���                                     conn_count             conns                                                              node_paths              editable_instances              version             RSRC�sܩ��RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene $   res://scenes/levels/base_level.tscn ��-r��Z      local://PackedScene_0ogso           PackedScene          
         names "         test_level    player    	   variants                       node_count             nodes        �����������    ����              conn_count              conns               node_paths              editable_instances              base_scene              version             RSRCRSRC                     PackedScene            ��������                                                  fader_rect    color    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    script    _data 	   _bundled       Script    res://scripts/ui/fader.gd ��������      local://Animation_uhtyq U         local://Animation_yuw0q �         local://AnimationLibrary_hh2pj �         local://PackedScene_nf71d       
   Animation 
            hide          ?         value           	         
                                                times !             ?      transitions !        �?  �?      values                        �?                         update              
   Animation 
            show          ?         value           	         
                                                times !             ?      transitions !        �?  �?      values                                           �?      update                 AnimationLibrary                   hide                 show                   PackedScene          	         names "         fader    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator 
   libraries    AnimationPlayer    fader_rect    color 
   ColorRect    	   variants                        �?                                                             �?      node_count             nodes     3   ��������       ����                                                             	   ����   
                        ����                                                       conn_count              conns               node_paths              editable_instances              version             RSRC�h�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_unva2 �          PackedScene          	         names "         menu_button    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Button    	   variants            �?            node_count             nodes        ��������       ����                                       conn_count              conns               node_paths              editable_instances              version             RSRC�Z�y	#���RSRC                     PackedScene            ��������                                                  . 	   modulate    background_blur 	   material    shader_parameter/blur_radius    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    script    _data    shader 	   _bundled       Script    res://scripts/ui/pause_menu.gd ��������   Shader &   res://resources/shaders/blur.gdshader ��������   PackedScene !   res://scenes/ui/menu_button.tscn ���7���      local://Animation_ggqxh �         local://Animation_aoohy �         local://AnimationLibrary_1ev1d          local://ShaderMaterial_wdcyn w         local://PackedScene_bw1bt �      
   Animation             Close         �>	      
�#<
         value                                                                    times !            �>      transitions !        �?  �?      values            �?  �?  �?  �?     �?  �?  �?          update                 value                                                                      times !            �>      transitions !        �?  �?      values             A     �?      update              
   Animation             Open         �>	      
�#<
         value                                                                    times !            �>      transitions !        �?  �?      values            �?  �?  �?         �?  �?  �?  �?      update                 value                                                                      times !            �>      transitions !        �?  �?      values            �?      A      update                 AnimationLibrary                   Close                 Open                   ShaderMaterial                         PackedScene          	         names "   0      pause_menu 	   modulate    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   animator 
   libraries    AnimationPlayer    background_blur 	   material    TextureRect    margin_container %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    MarginContainer    menu_buttons 
   alignment    VBoxContainer    resume_button    text    settings_button    quit_button    quit_warning    visible $   theme_override_constants/separation    size_flags_vertical    bbcode_enabled    RichTextLabel    center_container    size_flags_horizontal    CenterContainer    quit_buttons    HBoxContainer    quit_confirm    quit_cancel    _on_resume_button_pressed    pressed    _on_settings_button_pressed    _on_quit_button_pressed    _on_quit_confirm_pressed    _on_quit_cancel_pressed    	   variants            �?  �?  �?                     �?                                                               @                  Resume    	   Settings       Quit                 0   [center]Are you sure you want to quit?[/center]       Yes       No       node_count             nodes     �   ��������	       ����                                                                   
   ����                           ����                                                               ����
                                          	      	      
      
                    ����                          ���                                ���                                ���                                      ����                  
              "      ����                !                       %   #   ����         $          
       '   &   ����            
              ���(                                ���)                               conn_count             conns     #          +   *                     +   ,                     +   -                     +   .                     +   /                    node_paths              editable_instances              version             RSRC�z���DB@�RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/main.gd ��������   PackedScene &   res://scenes/levels/intro_screen.tscn ��������      local://PackedScene_r8m3w O         PackedScene          	         names "         main    layout_mode    anchors_preset    script    Control    screen_container    offset_right    offset_bottom    SubViewportContainer    screen    disable_3d    handle_input_locally    size    render_target_update_mode    SubViewport    intro_screen    	   variants    	                                B             -   �                         node_count             nodes     0   ��������       ����                                        ����                                   	   ����   
                                   ���                    conn_count              conns               node_paths              editable_instances              version             RSRCrn��o��M+�extends CharacterBody2D
class_name Actor

@export var move_speed: float = 250

@onready var animator: AnimationPlayer = $animator
@onready var sprite: Sprite2D = $sprite
@onready var collision: CollisionShape2D = $collision

var anim_name: String = "Idle Down"
var direction: Vector2

func _process(delta: float) -> void:
	set_anim()

func _physics_process(delta: float) -> void:
	move()
	
func move() -> void:
	velocity = velocity.normalized() * move_speed
	move_and_slide()
	
func set_anim():
	if velocity.x > 0:
		transform.x.x = 1
		anim_name = "Walk Side"
	elif velocity.x < 0:
		transform.x.x = -1
		anim_name = "Walk Side"
	if velocity.y > 0:
		anim_name = "Walk Down"
	elif velocity.y < 0:
		anim_name = "Walk Up"
	if velocity.length() <= 0:
		anim_name = anim_name.replace("Walk", "Idle")
	# animator.play(anim_name)
���g�extends Actor

func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	super._process(delta)
		
��extends Node2D

enum Scene {
	IntroScreen,
	MainMenu,
	Level,
}

@onready var scenes: Dictionary = {
	Scene.IntroScreen: preload("res://scenes/levels/intro_screen.tscn"),
	Scene.MainMenu: preload("res://scenes/levels/main_menu.tscn"),
	Scene.Level: preload("res://scenes/levels/test_level.tscn"),
}

@onready var screen: SubViewport = get_node("/root/main/screen_container/screen")

signal scene_changed(old_scene: String, new_scene: Scene)

var current_scene: String

func change_scene(scene_type: Scene) -> void:
	var fader: BaseUI = UIManager.open_ui(UIManager.UI.Fader)
	var fader_animator: AnimationPlayer = fader.get_node("animator")
	var old_scene = get_tree().current_scene
	await fader_animator.animation_finished
	for child in screen.get_children():
		screen.remove_child(child)
	var instanced_scene = scenes[scene_type].instantiate()
	screen.add_child(instanced_scene)
	UIManager.close_ui(UIManager.UI.Fader)
	current_scene = instanced_scene.name
	await fader_animator.animation_finished
	scene_changed.emit(old_scene, scene_type)
�T_���C���	�extends Control

@onready var gui: CanvasLayer = $gui

enum UI {
	Fader,
	PauseMenu,
}

@onready var uis: Dictionary = {
	UI.Fader: preload("res://scenes/ui/fader.tscn"),
	UI.PauseMenu: preload("res://scenes/ui/pause_menu.tscn"),
}

var active_uis: Array
var inactive_uis: Array
var instanced_uis: Dictionary
var current_ui: BaseUI

func open_ui(ui_type: UI, re_instance: bool = false) -> BaseUI:
	var ui: BaseUI = null
	if re_instance:
		free_ui(ui_type)
		ui = instance_ui(ui_type)
	else:
		ui = get_ui(ui_type)
	current_ui = ui
	ui.open()
	if not active_uis.has(ui):
		active_uis.append(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	return ui

func close_ui(ui_type: UI, free: bool = false) -> BaseUI:
	if not uis.has(ui_type):
		return null
	var ui: BaseUI = instanced_uis[ui_type]
	ui.close()
	if not inactive_uis.has(ui):
		inactive_uis.append(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if free:
		free_ui(ui_type)
		return null
	current_ui = active_uis[-1] if len(active_uis) > 0 else null
	return ui

func get_ui(ui_type: UI) -> BaseUI:
	if not uis.has(ui_type):
		return null
	if not instanced_uis.has(ui_type) or instanced_uis[ui_type] == null:
		instance_ui(ui_type)
	if not is_instance_valid(instanced_uis[ui_type]):
		return null
	var ui: BaseUI = instanced_uis[ui_type]
	return ui

func instance_ui(ui_type: UI, start_open = false) -> BaseUI:
	if not uis.has(ui_type):
		return null
	var instanced_ui: BaseUI = uis[ui_type].instantiate()
	instanced_ui.name = str(ui_type)
	instanced_uis[ui_type] = instanced_ui
	gui.add_child(instanced_ui)
	if not start_open:
		instanced_ui.hide()
	return instanced_ui

func free_ui(ui_type: UI) -> void:
	if not uis.has(ui_type):
		return
	var ui: BaseUI = instanced_uis[ui_type]
	if ui == null: return
	instanced_uis.erase(ui)
	if active_uis.has(ui):
		active_uis.erase(ui)
	if inactive_uis.has(ui):
		inactive_uis.erase(ui)
	ui.queue_free()

func initialize_in_game_uis() -> void:
	get_ui(UI.PauseMenu)
]4�U|i��extends Node2D

@onready var player: Actor = $player

func _ready() -> void:
	UIManager.initialize_in_game_uis()
�g��W7����$extends Control

@onready var animator: AnimationPlayer = $animator

func _ready() -> void:
	animator.play("start")
	await animator.animation_finished
	SceneManager.change_scene(SceneManager.Scene.MainMenu)
Sextends Control

@onready var quit_button: Button = $margin_container/menu_buttons/quit_button

func _ready() -> void:
	match OS.get_name():
		"Windows", "macOS", "Linux":
			quit_button.show()
			
	if UIManager.get_ui(UIManager.UI.PauseMenu) != null:
		UIManager.free_ui(UIManager.UI.PauseMenu)
	
func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	SceneManager.change_scene(SceneManager.Scene.Level)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
?�"�o,�extends Control
class_name BaseUI

signal opened(ui)
signal closed(ui)

var is_open: bool

func open() -> void:
	show()
	opened.emit(self)
	is_open = true

func close() -> void:
	hide()
	closed.emit(self)
	is_open = false
M�extends BaseUI

@onready var animator: AnimationPlayer = $animator

func open() -> void:
	super.open()
	animator.play("show")
	
func close() -> void:
	animator.play("hide")
	await animator.animation_finished
	super.close()
�extends BaseUI

@onready var animator: AnimationPlayer = $animator
@onready var background_blur: TextureRect = $background_blur
@onready var margin_container: MarginContainer = $margin_container
@onready var menu_buttons: VBoxContainer = margin_container.get_node("menu_buttons")
@onready var quit_warning: VBoxContainer = margin_container.get_node("quit_warning")

func _ready() -> void:
	background_blur.texture = get_window().get_texture()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_open:
			UIManager.close_ui(UIManager.UI.PauseMenu)
		else:
			UIManager.open_ui(UIManager.UI.PauseMenu)
			
func open() -> void:
	super.open()
	pause()
	animator.play("Open")
	await animator.animation_finished
	
	
func close() -> void:
	print("CLOSE PAUSE")
	animator.play("Close")
	await animator.animation_finished
	pause(false)
	super.close()
	
func pause(do_pause: bool = true) -> void:
	get_tree().set_pause(do_pause)

func _on_resume_button_pressed() -> void:
	close()

func _on_settings_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	menu_buttons.hide()
	quit_warning.show()

func _on_quit_confirm_pressed() -> void:
	close()
	SceneManager.change_scene(SceneManager.Scene.MainMenu)

func _on_quit_cancel_pressed() -> void:
	quit_warning.hide()
	menu_buttons.show()
���r��bMextends Control
GST2   �   �      ����               � �        $  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�5��I��'���F�"ɹ{�p����	"+d������M�q��� .^>и��6��a�q��gD�h:L��A�\D�
�\=k�(���_d2W��dV#w�o�	����I]�q5�*$8Ѡ$G9��lH]��c�LX���ZӞ3֌����r�2�2ؽL��d��l��1�.��u�5�!�]2�E��`+�H&�T�D�ި7P��&I�<�ng5�O!��͙������n�
ؚѠ:��W��J�+�����6��ɒ�HD�S�z�����8�&�kF�j7N�;YK�$R�����]�VٶHm���)�rh+���ɮ�d�Q��
����]	SU�9�B��fQm]��~Z�x.�/��2q���R���,snV{�7c,���p�I�kSg�[cNP=��b���74pf��)w<:Ŋ��7j0���{4�R_��K܅1�����<߁����Vs)�j�c8���L�Um% �*m/�*+ �<����S��ɩ��a��?��F�w��"�`���BrV�����4�1�*��F^���IKJg`��MK������!iVem�9�IN3;#cL��n/�i����q+������trʈkJI-����R��H�O�ܕ����2
���1&���v�ֳ+Q4蝁U
���m�c�����v% J!��+��v%�M�Z��ꚺ���0N��Q2�9e�qä�U��ZL��䜁�u_(���I؛j+0Ɩ�Z��}�s*�]���Kܙ����SG��+�3p�Ei�,n&���>lgC���!qյ�(_e����2ic3iڦ�U��j�q�RsUi����)w��Rt�=c,if:2ɛ�1�6I�����^^UVx*e��1�8%��DzR1�R'u]Q�	�rs��]���"���lW���a7]o�����~P���W��lZ�+��>�j^c�+a��4���jDNὗ�-��8'n�?e��hҴ�iA�QH)J�R�D�̰oX?ؿ�i�#�?����g�к�@�e�=C{���&��ށ�+ڕ��|h\��'Ч_G�F��U^u2T��ӁQ%�e|���p ���������k	V����eq3���8 � �K�w|�Ɗ����oz-V���s ����"�H%* �	z��xl�4��u�"�Hk�L��P���i��������0�H!�g�Ɲ&��|bn�������]4�"}�"���9;K���s��"c. 8�6�&��N3R"p�pI}��*G��3@�`��ok}��9?"@<�����sv� ���Ԣ��Q@,�A��P8��2��B��r��X��3�= n$�^ ������<ܽ�r"�1 �^��i��a �(��~dp-V�rB�eB8��]
�p ZA$\3U�~B�O ��;��-|��
{�V��6���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���H�#2:E(*�H���{��>��&!��$| �~�\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j���	P:�a�G0 �J��$�M���@�Q��[z��i��~q�1?�E�p�������7i���<*�,b�е���Z����N-
��>/.�g�'R�e��K�)"}��K�U�ƹ�>��#�rw߶ȑqF�l�Ο�ͧ�e�3�[䴻o�L~���EN�N�U9�������w��G����B���t��~�����qk-ί�#��Ξ����κ���Z��u����;{�ȴ<������N�~���hA+�r ���/����~o�9>3.3�s������}^^�_�����8���S@s%��]K�\�)��B�w�Uc۽��X�ǧ�;M<*)�ȝ&����~$#%�q����������Q�4ytz�S]�Y9���ޡ$-5���.���S_��?�O/���]�7�;��L��Zb�����8���Guo�[''�،E%���;����#Ɲ&f��_1�߃fw�!E�BX���v��+�p�DjG��j�4�G�Wr����� 3�7��� ������(����"=�NY!<l��	mr�՚���Jk�mpga�;��\)6�*k�'b�;	�V^ݨ�mN�f�S���ն�a���ϡq�[f|#U����^����jO/���9͑Z��������.ɫ�/���������I�D��R�8�5��+��H4�N����J��l�'�כ�������H����%"��Z�� ����`"��̃��L���>ij~Z,qWXo�}{�y�i�G���sz�Q�?�����������lZdF?�]FXm�-r�m����Ф:�З���:}|x���>e������{�0���v��Gş�������u{�^��}hR���f�"����2�:=��)�X\[���Ů=�Qg��Y&�q�6-,P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸~��f��i���_�j�S-|��w�R�<Lծd�ٞ,9�8��I�Ү�6 *3�ey�[�Ԗ�k��R���<������
g�R���~��a��
��ʾiI9u����*ۏ�ü�<mԤ���T��Amf�B���ĝq��iS��4��yqm-w�j��̝qc�3�j�˝mqm]P��4���8i�d�u�΄ݿ���X���KG.�?l�<�����!��Z�V�\8��ʡ�@����mK�l���p0/$R�����X�	Z��B�]=Vq �R�bk�U�r�[�� ���d�9-�:g I<2�Oy�k���������H�8����Z�<t��A�i��#�ӧ0"�m�:X�1X���GҖ@n�I�겦�CM��@������G"f���A$�t�oyJ{θxOi�-7�F�n"�eS����=ɞ���A��Aq�V��e����↨�����U3�c�*�*44C��V�:4�ĳ%�xr2V�_)^�a]\dZEZ�C 
�*V#��	NP��\�(�4^sh8T�H��P�_��}����[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ctbubyd7jexb1"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 ��I�7V�i°uJ[remap]

path="res://.godot/exported/133200997/export-e83d57cb3ac7e250efcb42c792ae42ff-actor.scn"
��ܰ�&ۄ#&��>[remap]

path="res://.godot/exported/133200997/export-087d785bf5027725196895bd45adeefe-player.scn"
��A+i�c�N [remap]

path="res://.godot/exported/133200997/export-665cf148b2def68f9680438c20b962a6-scene_manager.scn"
���T�[remap]

path="res://.godot/exported/133200997/export-d9f84698d1f40b895b805aa8f950c516-ui_manager.scn"
>p'�5�%[remap]

path="res://.godot/exported/133200997/export-255f7d8b8f8914312e6e0cbb54f15538-base_level.scn"
:Y!,7�[remap]

path="res://.godot/exported/133200997/export-d8a47e9d00b7401c2997ba1ae72757ba-intro_screen.scn"
��p�2[remap]

path="res://.godot/exported/133200997/export-c9d4cdb98d2720f278f6e650c673ef49-main_menu.scn"
�s�-KFt[remap]

path="res://.godot/exported/133200997/export-181dbcc3dd6a789c1134295f55411c07-test_level.scn"
� Ű")p[remap]

path="res://.godot/exported/133200997/export-b056546710644e3494421d9ef8e17783-fader.scn"
�pOy����PNZ$Tv[remap]

path="res://.godot/exported/133200997/export-b8f81b3416be30cf7c843e5bd7441b82-menu_button.scn"
s�_�z{�[remap]

path="res://.godot/exported/133200997/export-14114c379f76b1c04097459e2387a1e6-pause_menu.scn"
)�5a.p�[remap]

path="res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn"
"���2�nM{�0<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><g transform="translate(32 32)"><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99z" fill="#363d52"/><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99zm0 4h96c6.64 0 12 5.35 12 11.99v95.98c0 6.64-5.35 11.99-12 11.99h-96c-6.64 0-12-5.35-12-11.99v-95.98c0-6.64 5.36-11.99 12-11.99z" fill-opacity=".4"/></g><g stroke-width="9.92746" transform="matrix(.10073078 0 0 .10073078 12.425923 2.256365)"><path d="m0 0s-.325 1.994-.515 1.976l-36.182-3.491c-2.879-.278-5.115-2.574-5.317-5.459l-.994-14.247-27.992-1.997-1.904 12.912c-.424 2.872-2.932 5.037-5.835 5.037h-38.188c-2.902 0-5.41-2.165-5.834-5.037l-1.905-12.912-27.992 1.997-.994 14.247c-.202 2.886-2.438 5.182-5.317 5.46l-36.2 3.49c-.187.018-.324-1.978-.511-1.978l-.049-7.83 30.658-4.944 1.004-14.374c.203-2.91 2.551-5.263 5.463-5.472l38.551-2.75c.146-.01.29-.016.434-.016 2.897 0 5.401 2.166 5.825 5.038l1.959 13.286h28.005l1.959-13.286c.423-2.871 2.93-5.037 5.831-5.037.142 0 .284.005.423.015l38.556 2.75c2.911.209 5.26 2.562 5.463 5.472l1.003 14.374 30.645 4.966z" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 919.24059 771.67186)"/><path d="m0 0v-47.514-6.035-5.492c.108-.001.216-.005.323-.015l36.196-3.49c1.896-.183 3.382-1.709 3.514-3.609l1.116-15.978 31.574-2.253 2.175 14.747c.282 1.912 1.922 3.329 3.856 3.329h38.188c1.933 0 3.573-1.417 3.855-3.329l2.175-14.747 31.575 2.253 1.115 15.978c.133 1.9 1.618 3.425 3.514 3.609l36.182 3.49c.107.01.214.014.322.015v4.711l.015.005v54.325c5.09692 6.4164715 9.92323 13.494208 13.621 19.449-5.651 9.62-12.575 18.217-19.976 26.182-6.864-3.455-13.531-7.369-19.828-11.534-3.151 3.132-6.7 5.694-10.186 8.372-3.425 2.751-7.285 4.768-10.946 7.118 1.09 8.117 1.629 16.108 1.846 24.448-9.446 4.754-19.519 7.906-29.708 10.17-4.068-6.837-7.788-14.241-11.028-21.479-3.842.642-7.702.88-11.567.926v.006c-.027 0-.052-.006-.075-.006-.024 0-.049.006-.073.006v-.006c-3.872-.046-7.729-.284-11.572-.926-3.238 7.238-6.956 14.642-11.03 21.479-10.184-2.264-20.258-5.416-29.703-10.17.216-8.34.755-16.331 1.848-24.448-3.668-2.35-7.523-4.367-10.949-7.118-3.481-2.678-7.036-5.24-10.188-8.372-6.297 4.165-12.962 8.079-19.828 11.534-7.401-7.965-14.321-16.562-19.974-26.182 4.4426579-6.973692 9.2079702-13.9828876 13.621-19.449z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 104.69892 525.90697)"/><path d="m0 0-1.121-16.063c-.135-1.936-1.675-3.477-3.611-3.616l-38.555-2.751c-.094-.007-.188-.01-.281-.01-1.916 0-3.569 1.406-3.852 3.33l-2.211 14.994h-31.459l-2.211-14.994c-.297-2.018-2.101-3.469-4.133-3.32l-38.555 2.751c-1.936.139-3.476 1.68-3.611 3.616l-1.121 16.063-32.547 3.138c.015-3.498.06-7.33.06-8.093 0-34.374 43.605-50.896 97.781-51.086h.066.067c54.176.19 97.766 16.712 97.766 51.086 0 .777.047 4.593.063 8.093z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 784.07144 817.24284)"/><path d="m0 0c0-12.052-9.765-21.815-21.813-21.815-12.042 0-21.81 9.763-21.81 21.815 0 12.044 9.768 21.802 21.81 21.802 12.048 0 21.813-9.758 21.813-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 389.21484 625.67104)"/><path d="m0 0c0-7.994-6.479-14.473-14.479-14.473-7.996 0-14.479 6.479-14.479 14.473s6.483 14.479 14.479 14.479c8 0 14.479-6.485 14.479-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 367.36686 631.05679)"/><path d="m0 0c-3.878 0-7.021 2.858-7.021 6.381v20.081c0 3.52 3.143 6.381 7.021 6.381s7.028-2.861 7.028-6.381v-20.081c0-3.523-3.15-6.381-7.028-6.381" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 511.99336 724.73954)"/><path d="m0 0c0-12.052 9.765-21.815 21.815-21.815 12.041 0 21.808 9.763 21.808 21.815 0 12.044-9.767 21.802-21.808 21.802-12.05 0-21.815-9.758-21.815-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 634.78706 625.67104)"/><path d="m0 0c0-7.994 6.477-14.473 14.471-14.473 8.002 0 14.479 6.479 14.479 14.473s-6.477 14.479-14.479 14.479c-7.994 0-14.471-6.485-14.471-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 656.64056 631.05679)"/></g></svg>
v�   \1{,G   res://scenes/actors/actor.tscn5�$�
ji   res://scenes/actors/player.tscnv�۩��?(   res://scenes/autoload/scene_manager.tscnX��m�[�Y%   res://scenes/autoload/ui_manager.tscn��-r��Z#   res://scenes/levels/base_level.tscn���HaMNb"   res://scenes/levels/main_menu.tscn燎lj�#   res://scenes/levels/test_level.tscn�]�'��   res://scenes/ui/fader.tscn���7���    res://scenes/ui/menu_button.tscn�!k�/   res://scenes/ui/pause_menu.tscnq�
��ș4   res://scenes/main.tscn�P�s��T   res://icon.svg�����_��k8z�ECFG      application/config/name         GMTK Game Jam 2023     application/run/main_scene          res://scenes/main.tscn     application/config/features(   "         4.0    GL Compatibility        application/boot_splash/bg_color                    �?"   application/boot_splash/show_image             application/config/icon         res://icon.svg     application/run/name         GMTK Game Jam 2023     autoload/UIManager0      &   *res://scenes/autoload/ui_manager.tscn     autoload/SceneManager4      )   *res://scenes/autoload/scene_manager.tscn   "   display/window/size/viewport_width      �  #   display/window/size/viewport_height           display/window/stretch/mode         viewport   display/window/stretch/aspect         expand     dotnet/project/assembly_name         Game Template   #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility��