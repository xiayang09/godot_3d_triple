RSRC                    VisualShader            ��������                                            V      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type 	   function    input_name    op_type 	   operator    parameter_name 
   qualifier    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections     	      local://Gradient_g3vk2 �	          local://GradientTexture2D_li2sg ^
      &   local://VisualShaderNodeTexture_ec5le �
      %   local://VisualShaderNodeUVFunc_7d0vs �
      $   local://VisualShaderNodeInput_xjney 3      '   local://VisualShaderNodeVectorOp_peu76 j      ,   local://VisualShaderNodeVec2Parameter_ydank �      -   local://VisualShaderNodeColorParameter_h2mta          local://VisualShader_o2typ �      	   Gradient       !      ��\?^�e?�6k?   $                    �?  �?  �?  �?  �?              �?         GradientTexture2D                    
     �?  �?         VisualShaderNodeTexture                                                   VisualShaderNodeUVFunc                             VisualShaderNodeInput             time          VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeVec2Parameter             speed          VisualShaderNodeColorParameter                       ColorParameter                   VisualShader          �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_toon;

uniform vec4 ColorParameter : source_color = vec4(1.000000, 1.000000, 1.000000, 1.000000);
uniform vec2 speed;
uniform sampler2D tex_frg_2;



void fragment() {
// ColorParameter:7
	vec4 n_out7p0 = ColorParameter;


// Input:4
	float n_out4p0 = TIME;


// Vector2Parameter:6
	vec2 n_out6p0 = speed;


// VectorOp:5
	vec2 n_out5p0 = vec2(n_out4p0) * n_out6p0;


// UVFunc:3
	vec2 n_in3p1 = vec2(1.00000, 1.00000);
	vec2 n_out3p0 = n_out5p0 * n_in3p1 + UV;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);
	float n_out2p1 = n_out2p0.r;


// Output:0
	ALBEDO = vec3(n_out7p0.xyz);
	ALPHA = n_out2p1;
	EMISSION = vec3(n_out7p0.xyz);


}
 $         8   
     �C  �B9            :   
      B  pC;            <   
     p�  �C=            >   
     M�  �C?            @   
     ��  �CA            B   
     M�  �CC            D   
         �E                                                                                                                RSRC