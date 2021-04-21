#version 330

uniform sampler2D texture;
uniform sampler2D lightmap;


varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;
in vec3 infoent;

const int GL_LINEAR = 9729;
const int GL_EXP = 2048;

uniform int fogMode;

void main() {
	gl_FragData[0] = texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st) * color;
	gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
	if (fogMode == GL_EXP) {
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, 1.0 - clamp(exp(-gl_Fog.density * gl_FogFragCoord), 0.0, 1.0));
	} else if (fogMode == GL_LINEAR) {
		gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Fog.color.rgb, clamp((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale, 0.0, 1.0));
	}
	if (infoent.x == 56){
		gl_FragData[0].rgb = vec3(0.1, 0.4, 0.7);
	}
	if (infoent.x == 14){
		gl_FragData[0].rgb = vec3(0.7, 0.7, 0.2);
	}
	if (infoent.x == 54){
		gl_FragData[0].rgb = vec3(0.9, 0.6, 0.2);
	}
}