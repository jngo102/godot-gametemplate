// Implementation of Gaussian blur
shader_type canvas_item;

// 2 * PI
const float tau = 6.28318530717958647692528;
// Euler's constant
const float E = 2.71728182845904523536028;
// Standard deviation of Gaussian function
const float sigma = 1.5;

// Size of Gaussian kernel
uniform float blur_radius: hint_range(1, 15) = 5;

// Calculates the Gaussian of the given x and y
float gaussian(float x, float y)
{
	float sigma_squared = sigma * sigma;
	float amplitude = 1.0 / (tau * sigma_squared);
	float exponent = -((x * x) + (y * y)) / (2.0 * sigma_squared);
	return amplitude * pow(E, exponent);
}

vec4 blur13(sampler2D image, vec2 uv, vec2 resolution, vec2 direction) {
	vec4 color = vec4(0.0);
	vec2 off1 = vec2(1.411764705882353) * direction;
	vec2 off2 = vec2(3.2941176470588234) * direction;
	vec2 off3 = vec2(5.176470588235294) * direction;
	color += texture(image, uv) * 0.1964825501511404;
	color += texture(image, clamp(uv + (off1 / resolution), vec2(0), vec2(1))) * 0.2969069646728344;
	color += texture(image, clamp(uv - (off1 / resolution), vec2(0), vec2(1))) * 0.2969069646728344;
	color += texture(image, clamp(uv + (off2 / resolution), vec2(0), vec2(1))) * 0.09447039785044732;
	color += texture(image, clamp(uv - (off2 / resolution), vec2(0), vec2(1))) * 0.09447039785044732;
	color += texture(image, clamp(uv + (off3 / resolution), vec2(0), vec2(1))) * 0.010381362401148057;
	color += texture(image, clamp(uv - (off3 / resolution), vec2(0), vec2(1))) * 0.010381362401148057;
	return color;
}

void fragment() 
{
	float total_weight = 0.0;
	vec4 color = vec4(0.0);

	for (float x = -(blur_radius - 1.0) / 2.0; x <= (blur_radius - 1.0) / 2.0; x++)
	{
		for (float y = -(blur_radius - 1.0) / 2.0; y <= (blur_radius - 1.0) / 2.0; y++)
		{
			vec2 uv = vec2(SCREEN_UV.x + (x * TEXTURE_PIXEL_SIZE.x), SCREEN_UV.y + (y * TEXTURE_PIXEL_SIZE.y));
			float weight = gaussian(uv.x, uv.y);
			vec4 pixel_color = texture(SCREEN_TEXTURE, uv);
			total_weight += weight;
			color += pixel_color * weight;
		}
	}

	COLOR = color / total_weight;
//	COLOR = blur13(TEXTURE, UV, vec2(1024, 600), vec2(1, 1));
}