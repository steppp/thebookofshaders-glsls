precision mediump float;

# define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float plot(vec2 st, float pct) {
    // create a plot 0.04 units wide which fades as it approaches full thickness
    return smoothstep(pct - 0.01, pct, st.y) -
        smoothstep(pct, pct + 0.01, st.y);
}

// near identity using the root of a biased square
// n changes significantly the shape for low x values
// while it tends to vanish as x grows
// useful for symmetric functions such as mirrored SDFs
float almostIdentity(float x, float n) {
    return sqrt(x * x + n);
}

float almostUnitIdentity(float x) {
    return x * x * (2.0 - x);
}

// use k to control the stretching of the function
// the max (1) happens exactly at x = 1 / k
float expImpulse(float x, float k) {
    float h = k * x;
    return h * exp(1.0 - h);
}

// useful for some bouncing behaviors
// k controls the amount of bounces
// peaks at 1 but takes negative values
float sincCurve(float x, float k) {
    float a = PI * (k * x - 1.0);
    return sin(a) / a;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    // y = 0 if st.x < 0.5, 1 otherwise
    // float y = step(0.5, st.x);
    // smooth interpolation between 0.1 and 0.9
    // note that this collapses to step when min = max
    // float y = smoothstep(.1, .9, st.x);
    float y = sincCurve(st.x, 20.);
    vec3 color = vec3(y);

    float pct = plot(st, y);
    color = (1. - pct) * color + pct * vec3(0., 1., 0.);

    gl_FragColor = vec4(color, 1.);
}