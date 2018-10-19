#version 330 core

uniform mat4 matrix;
uniform mat4 shadow_map_matrix1;
uniform mat4 shadow_map_matrix2;
uniform vec3 camera;

in vec4 position;
in vec3 normal;
in vec2 uv;

out vec2 fragment_uv;
out vec4 shadow_coord1;
out vec4 shadow_coord2;
flat out float camera_distance;
flat out float fog_factor;
flat out float diffuse;

const vec3 light_direction = normalize(vec3(-1, 1, -1));

void main() {
    gl_Position = matrix * position;
    fragment_uv = uv;

    shadow_coord1 = (shadow_map_matrix1 * position + 1) / 2;
    shadow_coord2 = (shadow_map_matrix2 * position + 1) / 2;

    camera_distance = distance(camera, vec3(position));
    fog_factor = pow(clamp(camera_distance / 192, 0, 1), 4);
    diffuse = max(0, dot(normal, light_direction));
}
