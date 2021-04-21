#version 330 

varying vec4 texcoord;
varying vec4 color;
varying vec4 lmcoord;
attribute vec3 mc_Entity;
out vec3 infoent;

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
	float espvar = 99.0 * sqrt(position.x * position.x + position.y * position.y + position.z * position.z);
	color = gl_Color;
	if(true && (mc_Entity.x == 56 || mc_Entity.x == 14 || mc_Entity.x == 129 || mc_Entity.x == 54 || mc_Entity.x == 26)){
		color = vec4(1.0, 1.0, 1.0, 1.0);
			espvar = sqrt(espvar);
	if (true){
		position.x = position.x / espvar;
		position.y = position.y / espvar;
		position.z = position.z / espvar;
		}
	}
	
	gl_Position = gl_ProjectionMatrix * position;
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	gl_FogFragCoord = gl_Position.z;
	infoent = mc_Entity;
}