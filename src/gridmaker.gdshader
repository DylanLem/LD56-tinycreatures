shader_type canvas_item;
const int cell_buffer = 1;
const int cell_size = 3;
const int cell_padding = 6;

uniform vec2[512] colour_links;
uniform vec3[512] colour_link_colours;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 pixel_scale = 1./vec2(textureSize(TEXTURE,0));
	
	//if( (int(UV.x * float(textureSize(TEXTURE,0).x)) + 1) % 4 == 0  && (int(UV.y * float(textureSize(TEXTURE,0).y)) + 1) % 4 == 0
		//&& UV.x <= 0.5 - pixel_scale.x && UV.y < 1. - pixel_scale.y){
		//COLOR.r += 0.1;
	//}
	
	for(int i = 0; i < 512; i++){
		if(colour_links[i] != vec2(0)){
			if(int(UV.x * vec2(textureSize(TEXTURE,0)).x) == int(colour_links[i].x * float(cell_size + cell_buffer)) + 3 + cell_padding &&
			   int(UV.y * vec2(textureSize(TEXTURE,0)).y) == int(colour_links[i].y * float(cell_size + cell_buffer)) + 3){
				COLOR.rgb = colour_link_colours[i];
				COLOR.a = 1.;
			}
			
		}
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
