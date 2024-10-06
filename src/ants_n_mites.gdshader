shader_type canvas_item;

uniform int[128] ants;
uniform int[128] termites;
uniform float[128] ant_hp;
uniform float[128] termite_hp;

uniform float ant_max_hp;
uniform float termite_max_hp;


const int y_val = 24;


void fragment() {
	COLOR.rgba = vec4(0.0);
	for(int i = 0; i< 128; i++){
		if(ants[i] != 0){
			if(ants[i] == int(UV.x * float(textureSize(TEXTURE,0).x)) ){
				COLOR.rgba = vec4(1,0,0,1);
				COLOR.rgb *= ant_hp[i]/ant_max_hp;
			}
		}
		
		if(termites[i] != 0){
			if(termites[i] == int(UV.x * float(textureSize(TEXTURE,0).x)) ){
				COLOR.rgba = vec4(0,1,0,1);
				COLOR.rgb *= termite_hp[i]/termite_max_hp;
			}
		}
		
	}
	
		// Called for every pixel the material is visible on.
}
