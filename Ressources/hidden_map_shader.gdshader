shader_type canvas_item;

uniform vec2 player_pos;           // position du joueur en pixels
uniform float reveal_distance = 256.0;  // rayon d'effet maximal

void fragment() {
    // distance entre la tuile et le joueur
    float dist = distance(FRAGCOORD.xy, player_pos);
	
	if (dist < reveal_distance) {
	    // Calcul du facteur de luminosité
		float t = clamp(dist / reveal_distance, 0.0, 1.0); 
		float fade = smoothstep(0.0, 1.0, t);
		float brightness = mix(0, 1.0, fade);
		float alpha = mix(0, 1.0, fade);

		COLOR.rgb *= brightness;
		COLOR.a *= alpha;
	}
}
