shader_type spatial;

render_mode depth_draw_alpha_prepass, cull_disabled;

uniform float CURVATURE;
uniform bool CURVATURE_ACTIVE;
uniform float CURVATURE_DISTANCE;
uniform float SPRITE_POS_X;
uniform float SPRITE_POS_Y;

uniform sampler2D BASE_TEX;
uniform vec4 color;

varying vec4 world_vertex; // Declare a variável aqui para que ela seja acessível em ambas as funções

void vertex() {
    if (CURVATURE_ACTIVE == true) {
        vec4 vertex_world = (WORLD_MATRIX * vec4(VERTEX, 1.0)); // Declare a variável dentro da função vertex()
        float dist = length(CAMERA_MATRIX[3].xyz - vertex_world.xyz) / CURVATURE_DISTANCE;
        VERTEX.x += pow(dist, CURVATURE) * SPRITE_POS_X;
        VERTEX.y += pow(dist, CURVATURE) * SPRITE_POS_Y;
 // Inverta a direção da curvatura aqui (adicionando em vez de subtrair)
    }
    
    // Defina a variável varying world_vertex para que ela possa ser usada em fragment()
    world_vertex = (WORLD_MATRIX * vec4(VERTEX, 1.0));
}

void fragment() {
    vec4 tex = texture(BASE_TEX, UV);
    
    if (tex.a < 0.3) {
        discard;
    }
    
    // Use a variável varying world_vertex aqui para calcular a iluminação
    vec3 normal = normalize(world_vertex.xyz - (WORLD_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xyz); // Normal calculada após a deformação
    
    float diffuse = max(0.8, dot(normal, normalize(CAMERA_MATRIX[3].xyz - world_vertex.xyz)));
    
    ALBEDO = tex.rgb * color.rgb * diffuse;
    ALPHA  = tex.a;
}
// you can find the base of this shader in reddit
// https://www.reddit.com/r/godot/comments/t14wss/3d_world_bend_effect/
// If you improve this please show me