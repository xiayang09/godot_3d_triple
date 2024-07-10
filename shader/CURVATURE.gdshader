shader_type spatial;

//render_mode depth_prepass_alpha, cull_disabled;
render_mode blend_mix,cull_disabled,diffuse_burley,specular_schlick_ggx,depth_prepass_alpha;


uniform vec4 albedo : source_color = vec4(1,1,1,1);
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_roughness : hint_roughness_r,filter_linear_mipmap,repeat_enable;
uniform sampler2D texture_metallic : hint_default_white,filter_linear_mipmap,repeat_enable;
uniform float point_size : hint_range(0,128);
uniform float roughness : hint_range(0,1);
const vec4 metallic_texture_channel = vec4(1,1,1,1);
uniform float specular;
uniform float metallic;
uniform vec2 uv1_scale = vec2(1,1);
uniform vec2 uv1_offset = vec2(0,0);
uniform float CURVATURE = 2;
uniform bool CURVATURE_ACTIVE;
uniform float CURVATURE_DISTANCE = 2;
uniform float SPRITE_POS_Y;

varying vec4 world_vertex; // Declare a variável aqui para que ela seja acessível em ambas as funções

void vertex() {
    if (CURVATURE_ACTIVE == true) {
        vec4 vertex_world = (MODEL_MATRIX * vec4(VERTEX, 1.0)); // Declare a variável dentro da função vertex()
        float dist = length(INV_VIEW_MATRIX[3].xyz - vertex_world.xyz) / CURVATURE_DISTANCE;
        VERTEX.y += pow(dist, CURVATURE) * SPRITE_POS_Y;
 // Inverta a direção da curvatura aqui (adicionando em vez de subtrair)
    }
    // Defina a variável varying world_vertex para que ela possa ser usada em fragment()
    world_vertex = (MODEL_MATRIX * vec4(VERTEX, 1.0));
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	float metallic_tex = dot(texture(texture_metallic,base_uv),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	vec4 roughness_texture_channel = vec4(1.0,0.0,0.0,0.0);
	float roughness_tex = dot(texture(texture_roughness,base_uv),roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	SPECULAR = specular;
}
// you can find the base of this shader in reddit
// https://www.reddit.com/r/godot/comments/t14wss/3d_world_bend_effect/
// If you improve this please show me