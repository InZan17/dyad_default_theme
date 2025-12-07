#version 120
varying vec2 texcoord;
varying vec3 normal;
varying vec3 pos;

uniform sampler2D main_tex;
uniform float actor_ratio;
uniform vec4 premul_color;
uniform vec2 pixel_offset;
uniform int blur_size;

float gaussian(float x, float sigma) {
    return exp(-(x * x) / (2.0 * sigma * sigma));
}

void main() {
    vec3 color = vec3(0.0);
    float weightSum = 0.0;

    for (int i = -blur_size; i <= blur_size; ++i) {
        float w = gaussian(float(i), 0.3 * float(blur_size) + 0.8);
        vec2 samplepos = texcoord + pixel_offset * float(i);
        color += max(texture2D(main_tex, samplepos).rgb, 0.02) * w;
        weightSum += w;
    }

    gl_FragColor = vec4(color.rgb/weightSum, 1.0);
}