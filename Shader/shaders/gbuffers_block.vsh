// "The Wave", a wavy world shader that makes the world move like a rolling ocean.
// So yeah, possible seasickness warning.
// By Beed28

#version 120 // This will always get moved to the top of the code in pre-processing.

varying vec4 texcoord;
varying vec4 color;
varying vec4 lmcoord;

uniform float frameTimeCounter;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;


void main() {
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	vec4 position = gl_ModelViewMatrix * gl_Vertex;
	
	position = gbufferModelViewInverse * position;
	vec3 worldpos = position.xyz + cameraPosition;
	
	float PI = 3.14159265358979323846264;
	
	position = gbufferModelView * position;
	
	float espvar = 10.0 * sqrt(position.x * position.x + position.y * position.y + position.z * position.z);
	
	espvar = sqrt(espvar);
	if (true && espvar > 0.5){
		position.x = position.x / espvar;
		position.y = position.y / espvar;
		position.z = position.z / espvar;
	}
	
	gl_Position = gl_ProjectionMatrix * position;
		
	color = gl_Color;
	
	//gl_Color = vec4(1.0, 1.0, 1.0, 1.0);
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	gl_FogFragCoord = gl_Position.z;
}