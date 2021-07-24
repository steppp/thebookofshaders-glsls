precision mediump float;

# define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float plot(vec2 st, float pct) {
    // create a plot 0.04 units wide which fades as it approaches full thickness
    return smoothstep(pct - 0.02, pct, st.y) -
        smoothstep(pct, pct + 0.02, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    // y = 0 if st.x < 0.5, 1 otherwise
    // float y = step(0.5, st.x);
    // smooth interpolation between 0.1 and 0.9
    // note that this collapses to step when min = max
    // float y = smoothstep(.1, .9, st.x);
    float y = smoothstep(.2, .5, st.x) -
        smoothstep(.5, .8, st.x);
    vec3 color = vec3(y);

    float pct = plot(st, y);
    color = (1. - pct) * color + pct * vec3(0., 1., 0.);

    gl_FragColor = vec4(color, 1.);
}