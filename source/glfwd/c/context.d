module glfwd.c.context;
import glfwd.c.window;

extern(C) {
	alias void* GLFWglproc;
	
	void glfwMakeContextCurrent(GLFWwindow *window);
	GLFWwindow* glfwGetCurrentContext();
	void glfwSwapBuffers(GLFWwindow *window);
	void glfwSwapInterval(int interval);
	int glfwExtensionSupported(const char *extension);
	GLFWglproc glfwGetProcAddress(const char *procname);
}