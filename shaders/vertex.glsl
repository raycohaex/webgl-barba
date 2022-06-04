uniform float time;
varying vec2 vUv;
uniform vec2 resolution;
uniform vec2 quadSize;
uniform vec4 uCorners;
varying vec2 vSize;

void main() {
  vUv = uv;


  float PI = 3.1415926;
  float sine = sin(PI * time);
  // create a function where 0 and 1 are "off" and in between the highest number is 1
  // sin (3.141 * 1) = 0 
  // sin (3.141 * 0.5) = 1
  // sin (3.141 * 0) = 0 

  // wavy pattern
  float waves = sine * 0.1 * sin(5.*length(uv) + 15. * time);

  vec4 defaultState = modelMatrix * vec4(position, 1.0);
  vec4 fullScreenState = vec4 (position, 1.0);
  fullScreenState.x *=resolution.x/quadSize.x;
  fullScreenState.y *=resolution.y/quadSize.y;

  float cornersProgress = mix(
    mix(uCorners.x, uCorners.y, uv.x),
    mix(uCorners.z, uCorners.y, uv.x),
    uv.y
    );

  vec4 finalState = mix(defaultState, fullScreenState, cornersProgress + waves);

  vSize = mix(quadSize, resolution, time);

  gl_Position = projectionMatrix * viewMatrix * finalState;
}