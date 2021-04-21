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
	
	gl_Position = gl_ProjectionMatrix * position;
		
	color = gl_Color;
	
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	gl_FogFragCoord = gl_Position.z;
}