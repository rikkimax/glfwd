module glfwd.c.monitor;
public import glfwd.c.defs : GLFWmonitorfun;
public import glfwd.c.gamma : GLFWgammaramp;
import glfwd.monitor : IMonitor;

extern(C) {
	struct GLFWmonitor {
		IMonitor monitor;
	}
	
	struct GLFWvidmode {
		int width;
		int height;
		int redBits;
		int greenBits;
		int blueBits;
		int refreshRate;
	}
	
	GLFWmonitor** glfwGetMonitors(int* count);
	GLFWmonitor* glfwGetPrimaryIMonitor();
	void glfwGetMonitorPos(GLFWmonitor* IMonitor, int* xpos, int* ypos);
	void glfwGetMonitorPhysicalSize(GLFWmonitor* IMonitor, int* width, int* height);
	const char* glfwGetMonitorName(GLFWmonitor* IMonitor);
	GLFWmonitorfun glfwSetMonitorCallback(GLFWmonitorfun cbfun);
	const GLFWvidmode* glfwGetVideoModes(GLFWmonitor* IMonitor, int* count);
	const GLFWvidmode* glfwGetVideoMode(GLFWmonitor* IMonitor);
	void glfwSetGamma(GLFWmonitor* monitor, float gamma);
	const GLFWgammaramp* glfwGetGammaRamp(GLFWmonitor* IMonitor);
	void glfwSetGammaRamp(GLFWmonitor* Monitor, const GLFWgammaramp* ramp);
	
	void _glfwSplitBPP(int bpp, int* red, int* green, int* blue) {
		int delta;
		
		if (bpp == 32)
			bpp = 24;
		
		*red = *green = *blue = bpp / 3;
		delta = bpp - (*red * 3);
		if (delta >= 1)
			*green = *green + 1;
		
		if (delta == 2)
			*red = *red + 1;
	}
	
	bool _glfwPlatformIsSameMonitor(GLFWmonitor* first, GLFWmonitor* second) {
		return (*first).monitor.name == (*second).monitor.name;
	}
	
	int _glfwCompareVideoModes(const GLFWvidmode* first, const GLFWvidmode* second) {
		int firstBPP = (*first).redBits + (*first).greenBits + (*first).blueBits;
		int secondBPP = (*second).redBits + (*second).greenBits + (*second).blueBits;
		
		if (firstBPP != secondBPP)
			return firstBPP - secondBPP;
		
		int firstSize = (*first).width * (*first).height;
		int secondSize = (*second).width * (*second).height;
		
		if (firstSize != secondSize)
			return firstSize - secondSize;
		
		return (*first).refreshRate - (*second).refreshRate;
	}
}