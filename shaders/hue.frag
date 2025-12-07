#version 120
varying vec2 texcoord;

uniform sampler2D main_tex;
varying vec3 tint_color;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec4 tex_color = texture2D(main_tex, texcoord);
    tex_color.a = min(tex_color.a * 1.01, 1.0);
    vec3 hsv = rgb2hsv(tex_color.rgb);
    hsv.r *= tint_color.r;
    hsv.r += tint_color.g;
    hsv.g = 1.0;
    hsv.b = 1.0;
    vec3 rgb = hsv2rgb(hsv);
    gl_FragColor = vec4(rgb * tex_color.a, tex_color.a);
}