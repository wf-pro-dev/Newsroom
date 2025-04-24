// Fragment shader
//uniform vec3 glowColor;
//niform float coefficient;
//uniform float power;

varying vec3 vertexNormal;
//varying vec3 vPosition;

void main() {
    //vec3 viewDirection = normalize(-vPosition);
    float intensity = coefficient * pow(0.6 - dot(vertexNormal, vec3(0, 0, 1.0)), 2.0);
    
    // Create smooth atmospheric gradient
    //vec3 atmosphere = glowColor * fresnel;
    
    // Add rim lighting effect
    //float rimLight = 1.0 - max(0.0, dot(viewDirection, vNormal));
    //rimLight = pow(rimLight, 3.0);
    
    // Combine effects
    //vec3 finalColor = atmosphere + (glowColor * rimLight * 0.3);
    
    gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
}
