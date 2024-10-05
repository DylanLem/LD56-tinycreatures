shader_type canvas_item;

uniform int[128] ants;
uniform int[128] termites;

const int y_val = 64;


void fragment() {
	COLOR.rgba = vec4(0.0);
	for(int i = 0; i< 128; i++){
		if(ants[i] != 0){
			if(ants[i] == int(UV.x * float(textureSize(TEXTURE,0).x)) ){
				COLOR.rgba = vec4(1,0,0,1);
			}

		}
	}	// Called for every pixel the material is visible on.
}
