module glfwd.c.input;
import glfwd.c.window;
import glfwd.defs;

extern(C) {
	alias void function(GLFWwindow*, int, int, int) GLFWmousebuttonfun;
	alias void function(GLFWwindow*, double, double) GLFWcursorposfun;
	alias void function(GLFWwindow*, int) GLFWcursorenterfun;
	alias void function(GLFWwindow*, double, double) GLFWscrollfun;
	alias void function(GLFWwindow*, int, int, int, int) GLFWkeyfun;
	alias void function(GLFWwindow*, uint) GLFWcharfun;
	
	int glfwGetInputMode(GLFWwindow* window, int mode);
	void glfwSetInputMode(GLFWwindow* window, int mode, int value);
	int glfwGetKey(GLFWwindow* window, int key);
	int glfwGetMouseButton(GLFWwindow* window, int button);
	void glfwGetCursorPos(GLFWwindow* window, double* xpos, double* ypos);
	void glfwSetCursorPos(GLFWwindow* window, double xpos, double ypos);
	GLFWkeyfun glfwSetKeyCallback(GLFWwindow* window, GLFWkeyfun cbfun);
	GLFWcharfun glfwSetCharCallback(GLFWwindow* window, GLFWcharfun cbfun);
	GLFWmousebuttonfun glfwSetMouseButtonCallback(GLFWwindow* window, GLFWmousebuttonfun cbfun);
	GLFWcursorposfun glfwSetCursorPosCallback(GLFWwindow* window, GLFWcursorposfun cbfun);
	GLFWcursorenterfun glfwSetCursorEnterCallback(GLFWwindow* window, GLFWcursorenterfun cbfun);
	GLFWscrollfun glfwSetScrollCallback(GLFWwindow* window, GLFWscrollfun cbfun);
	int glfwJoystickPresent(int joy);
	const float* glfwGetJoystickAxes(int joy, int* count);
	const ubyte* glfwGetJoystickButtons(int joy, int* count);
	const byte* glfwGetJoystickName(int joy);
}