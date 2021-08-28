precision mediump float;

uniform vec2 u_resolution;

float rect(vec2 orig, vec2 size, vec2 st) {
    vec2 bl = step(vec2(orig.x, orig.y), st);
    vec2 tr = 1.0 - step(vec2(orig.x + size.x, orig.y + size.y), st);

    return bl.x * bl.y * tr.x * tr.y ;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);

    // return 1.0 (white) or 0.0 (black)
    // bottom left borders
    vec2 bl = smoothstep(vec2(0.2), vec2(0.22), st);   // equivalent to x greater than 0.1, y greater than 0.1
    // top right borders
    vec2 tr = smoothstep(vec2(0.1, 0.03), vec2(0.12, 0.05), 1.0 - st);

    // color = vec3(bl.x * bl.y * tr.x * tr.y);    // equivalent to left && bottom && right && top
    color = vec3(rect(vec2(0.0), vec2(0.5), st));
    color += vec3(rect(vec2(0.35, 0.75), vec2(0.25), st));
    color += vec3(rect(vec2(0.55, 0.0), vec2(0.45, 0.70), st));
    color += vec3(rect(vec2(0.0, 0.55), vec2(0.20, 0.45), st)) * vec3(0.2, 0.4, 0.8);

    gl_FragColor = vec4(color,  1.0);
}