precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float circleSdf(vec2 st, vec2 c, float r) {
    float pct = distance(st, c) * 2.0;
    return step(r, pct);
}

float circleSdf(vec2 st, vec2 c, float r, float blur) {
    if (blur == 0.0)
        return circleSdf(st, c, r);

    float pct = distance(st, c) * 2.0;
    return smoothstep(r, r+blur, pct);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    float pct = 0.0;

    // distance from this pixel to the center
    // pct = distance(st, vec2(0.5));
    // pct = distance(st,vec2(0.4)) + distance(st,vec2(0.6));
    // pct = distance(st,vec2(0.4)) * distance(st,vec2(0.6));
    // pct = min(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    // pct = max(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    // pct = pow(distance(st,vec2(0.4)),distance(st,vec2(0.6)));

    vec3 color = vec3(circleSdf(st, vec2(0.5), 0.5, 0.));
    // vec3 color = 1.0 - vec3(pct * 2.0);
    // color = step(0.5, color);
    // color = 1.0 - step(0.5, color);
    // color = smoothstep(0.2, 0.24, color);
    color *= vec3(0.4, 0.6, 0.2);

    vec2 c2Center = vec2(cos(u_time) * 0.2 + 0.5, sin(u_time) * 0.2 + 0.5);
    // vec2 c2Center = vec2(cos(st * 0.3) * 0.5 + 0.5, sin(st * 0.5) * 0.5 + 0.5);
    color *= vec3(circleSdf(st, c2Center, 0.4, 0.));

    gl_FragColor = vec4(color, 1.0);
}