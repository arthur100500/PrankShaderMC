// "The Wave", a wavy world shader that makes the world move like a rolling ocean.
// So yeah, possible seasickness warning.
// By Beed28

#version 330 // This will always get moved to the top of the code in pre-processing.
#define GREEN_SELECTION // Selects people in color 0 255 51 if they are hitable

const int esp = 1;

varying vec4 texcoord;
varying vec4 color;
varying vec4 lmcoord;

uniform float frameTimeCounter;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

out vec3 close_enough;


void main() {
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	vec4 position = gl_ModelViewMatrix * gl_Vertex;
	float multiplier = 50.0;
	position = gbufferModelViewInverse * position;
	vec3 worldpos = position.xyz + cameraPosition;
	
	float PI = 3.14159265358979323846264;
	
	position = gbufferModelView * position;
	
	float espvar = multiplier * sqrt(position.x * position.x + position.y * position.y + position.z * position.z);
	
	espvar = sqrt(espvar);
	
	if (espvar > 0.5){
	position.x = position.x / espvar;
	position.y = position.y / espvar;
	position.z = position.z / espvar;
	}
	close_enough = vec3(0.0, 0.0, 0.0);
	
	if (esp == 1){
		if (espvar < multiplier * 0.270){
			close_enough = vec3(1.0, 0.0, 0.0);
		}
	}
	color = gl_Color;
	
	gl_Position = gl_ProjectionMatrix * position;
	
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	gl_FogFragCoord = gl_Position.z;
}
