extern number time;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {
    return vec4(max(0.33,sin(time*6)), max(0.33,sin(time*6)), max(0.33,sin(time*6)), 1.0);
}
