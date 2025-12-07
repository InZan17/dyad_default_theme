#version 120
varying vec2 texcoord;
varying vec3 normal;
varying vec3 pos;

uniform sampler2D main_tex;
uniform sampler2D stem_tex;
uniform sampler2D smaller_blur_tex;
uniform float actor_ratio;
uniform vec4 premul_color;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 whiteout(vec3 c)
{
    float max_val = max(c.r, max(c.g, c.b));
    float whitening = max(max_val - 1.0, 0.0);
    vec3 whitencolor = max(vec3(1.0 - c.r, 1.0 - c.g, 1.0 - c.b), 0.0);
    return c + whitencolor * whitening;
}

void main() {
    vec4 bloom_tex_color = texture2D(main_tex, texcoord);
    vec4 smaller_blur_tex_color = texture2D(smaller_blur_tex, texcoord);
    vec4 stem_tex_color = texture2D(stem_tex, texcoord);

    vec3 stem_color;
    if (stem_tex_color.a > 0.0) {
        stem_color = whiteout(stem_tex_color.rgb * 1.95 / stem_tex_color.a) * stem_tex_color.a;
    } else {
        stem_color = vec3(0.0);
    }
    vec3 bloom_color = bloom_tex_color.rgb * 1.5;
    float add_white_bloom = rgb2hsv(smaller_blur_tex_color.rgb * 1.0).b;

    bloom_color = bloom_color * (1 - add_white_bloom) * 0.7 + vec3(add_white_bloom) * 0.5;

    gl_FragColor = vec4( stem_color + bloom_color * (1.0 - stem_tex_color.a), 1.0);
}