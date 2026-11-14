shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 0.2, 0.2, 1.0);
uniform float glow_strength = 0.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    COLOR = tex;
    COLOR.rgb += glow_color.rgb * glow_strength * tex.a;
}