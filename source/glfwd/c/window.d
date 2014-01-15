module glfwd.c.window;
public import glfwd.c.monitor : GLFWmonitor;
public import glfwd.window : IWindow;

extern(C) {
	struct GLFWwindow {
		IWindow window;
	}
	
	void glfwDefaultIWindowHints();
	void GLFWwindowHint();
	GLFWwindow* glfwCreateIWindow(int width, int height, const char* title, GLFWmonitor* IMonitor, GLFWwindow* share);
	void glfwDestroyIWindow(GLFWwindow* IWindow);
	int GLFWwindowShouldClose(GLFWwindow* IWindow);
	void glfwSetIWindowShouldClose(GLFWwindow* IWindow);
	void glfwSetIWindowShouldClose(GLFWwindow* IWindow, int value);
	void glfwSetIWindowTitle(GLFWwindow* IWindow, const char* title);
	void glfwGetIWindowPos(GLFWwindow* IWindow, int* xpos, int* ypos);
	void glfwSetIWindowPos(GLFWwindow* IWindow, int xpos, int ypos);
	void glfwGetIWindowSize(GLFWwindow* IWindow, int* width, int* height);
	void glfwSetIWindowSize(GLFWwindow* IWindow, int width, int height);
	void glfwGetFramebufferSize(GLFWwindow* IWindow, int* width, int* height);
	void glfwIconifyIWindow(GLFWwindow* IWindow);
	void glfwRestoreIWindow(GLFWwindow* IWindow);
	void glfwShowIWindow(GLFWwindow* IWindow);
	void glfwHideIWindow(GLFWwindow* IWindow);
	GLFWmonitor* glfwGetIWindowIMonitor(GLFWwindow* IWindow);
	int glfwGetIWindowAttrib(GLFWwindow* IWindow);
	void glfwSetIWindowUserPointer(GLFWwindow* IWindow, void* pointer);
	void* glfwGetIWindowUserPointer(GLFWwindow* IWindow);
	
	void glfwPollEvents();
	void glfwWaitEvents();
}