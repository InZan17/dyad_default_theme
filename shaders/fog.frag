#version 120
varying vec2 texcoord;
varying vec3 normal;
varying vec3 pos;
varying vec3 tint_color;
varying float opacity;

uniform sampler2D main_tex;
uniform sampler2D depth_tex;

float linearize(float d, float near, float far) {
    return (2.0 * near) / (far + near - d * (far - near));
}

void main() {
    float fog_end = 0.7;
    float fog_start = 0;

    vec4 tex_color = texture2D(main_tex, texcoord);
    vec4 depth_color = texture2D(depth_tex, texcoord);

    float linear_depth = linearize(depth_color.r, 0.1, 100.0);
    float fog_factor = clamp((fog_end - linear_depth) / (fog_end - fog_start), 0.0, 1.0);

    vec3 fog_color = vec3(14, 29, 50) / 255.0;

    vec3 final_color = tex_color.rgb;

    vec3 final_color_with_fog = mix(fog_color, final_color, fog_factor);
    
    gl_FragColor = vec4(final_color_with_fog, 1) * vec4(tint_color * opacity, opacity);
}