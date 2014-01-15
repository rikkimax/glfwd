module glfwd.c.gamma;
import glfwd.c.monitor;

extern(C) {
	struct GLFWgammaramp {
		ushort* red;
		ushort* green;
		ushort* blue;
		uint size;
	}
	
	void _glfwAllocGammaArrays(GLFWgammaramp* ramp, uint size) {
		ushort[] ra, ga, ba;
		
		ra.length = cast(size_t)size;
		ga.length = cast(size_t)size;
		ba.length = cast(size_t)size;
		
		(*ramp).red = ra.ptr;
		(*ramp).green = ga.ptr;
		(*ramp).blue = ba.ptr;
		
		(*ramp).size = size;
	}
	
	// lets not error for some reason if somebody were to use this!
	deprecated("Do not need to free arrays. We're D.")
	void _glfwFreeGammaArrays(GLFWgammaramp* ramp) {}
	
	void glfwSetGamma(GLFWmonitor* handle, float gamma);
	const GLFWgammaramp* glfwGetGammaRamp(GLFWmonitor* handle);
	void glfwSetGammaRamp(GLFWmonitor* handle, const GLFWgammaramp* ramp);
}